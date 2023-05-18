local M = {}

local last_string = '';
local function process_update(_, data, _)
  if #data == 1 and data[1] == '' then
    print('appearance watcher died')
    return
  end

  -- data can have incomplete lines between consecutive calls separated with ''
  -- complete the previous line first
  vim.opt.background = last_string .. data[1]
  -- normally only a single line will be passed at a time
  for i = 2, #data - 1 do
    vim.opt.background = data[i]
  end
  -- hold the final line (empty if all lines were complete)
  last_string = data[#data]
end

function M.setup()
  local defaults_cmd = 'defaults read -g AppleInterfaceStyle'
  -- the command returns 'Dark' for dark mode and fails otherwise with
  -- The domain/default pair of (kCFPreferencesAnyApplication, AppleInterfaceStyle) does not exist
  if os.execute(defaults_cmd) == 0 then
    vim.opt.background = 'dark'
  else
    vim.opt.background = 'light'
  end

  if vim.fn.executable('./appearance') == 0 then
    if vim.fn.executable('swiftc') == 0 then
      return
    end
    local swiftc_status = os.execute('swiftc ./macos/appearance.swift')
    if swiftc_status ~= 0 then
      print('watcher compilation failed')
      return
    end
  end

  vim.fn.jobstart('./appearance', { on_stdout = process_update })
end

return M
