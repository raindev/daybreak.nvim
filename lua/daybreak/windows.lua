local M = {}

function M.setup(sunrise, sunset)
  local reg_cmd = 'reg query'
      .. ' HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize'
      .. ' /v AppsUseLightTheme'
  local reg_stdout = io.popen(reg_cmd)
  if reg_stdout == nil then
    print('can\'t execute reg')
    return
  end
  local stdout_str = reg_stdout:read('*a')
  local exit_success = reg_stdout:close()
  if exit_success ~= true then
    print('reg command failed')
    return
  end
  local value = stdout_str:match('AppsUseLightTheme%s+REG_DWORD%s+0x(%d+)')
  if value == nil then
    print('unrecognized registry value')
    return
  end
  vim.opt.background = value == '1' and 'light' or 'dark'
  if value == 1 then
    sunrise()
  else
    sunset()
  end
end

return M
