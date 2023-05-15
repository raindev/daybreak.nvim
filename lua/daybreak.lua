local gdbus = require('gdbus')
local macos = require('macos')
local windows = require('windows')

local M = {}

function M.setup(_)
  if vim.fn.has('osx') == 1 then
    macos.setup()
  elseif vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    windows.setup()
  elseif vim.fn.executable('gdbus') == 1 then
    gdbus.setup()
  end
end

return M
