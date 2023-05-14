local M = {}

function M.setup()
  local defaults_cmd = 'defaults read -g AppleInterfaceStyle'
  -- the command returns 'Dark' for dark mode and fails otherwise with
  -- The domain/default pair of (kCFPreferencesAnyApplication, AppleInterfaceStyle) does not exist
  if os.execute(defaults_cmd) == 0 then
    vim.opt.background = 'dark'
  else
    vim.opt.background = 'light'
  end
end

return M
