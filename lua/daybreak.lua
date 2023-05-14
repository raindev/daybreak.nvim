local function set_background(s, mode_index)
  local is_light = string.sub(s, mode_index, mode_index) == '0'
  if is_light then
    vim.opt.background = 'light'
  else
    vim.opt.background = 'dark'
  end
end

local prefix = "/org/freedesktop/portal/desktop:"
    .. " org.freedesktop.portal.Settings.SettingChanged"
    .. " ('org.freedesktop.appearance', 'color-scheme', <uint32 ";
local function process_line(line)
  if string.sub(line, 1, #prefix) == prefix then
    set_background(line, #prefix + 1)
  end
end

local last_string = '';
local function process_update(_, data, _)
  if #data == 1 and data[1] == '' then
    -- TODO should the command be restarted?
    print('gdbus monitor command died')
    return
  end

  -- data can have incomplete lines between consecutive calls separated with ''
  -- complete the previous line first
  process_line(last_string .. data[1])
  -- process full lines
  for i = 2, #data - 1 do
    process_line(data[i])
  end
  -- hold the final line (empty if all lines were complete)
  last_string = data[#data]
end

local M = {}

function M.setup(_)
  local gdbus_read = 'gdbus call --session'
      .. ' --dest=org.freedesktop.portal.Desktop'
      .. ' --object-path=/org/freedesktop/portal/desktop'
      .. ' --method=org.freedesktop.portal.Settings.Read'
      .. ' org.freedesktop.appearance color-scheme'
  local gdbus_stdout = io.popen(gdbus_read)
  if gdbus_stdout ~= nil then
    local stdout_str = gdbus_stdout:read('*a')
    local exit_success = gdbus_stdout:close()
    if exit_success ~= true then
      print('gdbus command failed')
    end
    set_background(stdout_str, #'(<<uint32 ' + 1)
  else
    print('can\'t execute gdbus')
  end

  local gdbus_monitor = 'gdbus monitor --session'
      .. ' --dest org.freedesktop.portal.Desktop'
      .. ' --object-path'
      .. ' /org/freedesktop/portal/desktop'
  vim.fn.jobstart(gdbus_monitor, { on_stdout = process_update })
end

return M
