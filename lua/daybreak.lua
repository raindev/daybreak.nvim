local M = {}

function M.setup(_)
  local command = 'gdbus call --session --dest=org.freedesktop.portal.Desktop --object-path=/org/freedesktop/portal/desktop --method=org.freedesktop.portal.Settings.Read org.freedesktop.appearance color-scheme'
  local file = io.popen(command)
  if file ~= nil then
    local output = file:read('*a')
    local exit = file:close()
    if exit ~= true then
      print('gdbus command failed')
    end
    local response_index = #'(<<uint32 ' + 1
    local is_light = string.sub(output, response_index, response_index) == '0'
    if is_light then
      vim.opt.background = 'light'
    else
      vim.opt.background = 'dark'
    end
  else
    print('can\'t execute gdbus')
  end
end

return M
