local gdbus = require('gdbus')
local macos = require('macos')
local windows = require('windows')

local M = {}

function M.setup(opts)
  local sunrise = function()
    vim.opt.background = 'dark'
    if opts and opts.light then
      vim.cmd('colorscheme ' .. opts.light)
    end
  end
  local sunset = function()
    vim.opt.background = 'dark'
    if opts and opts.dark then
      vim.cmd('colorscheme ' .. opts.dark)
    end
  end
  local helios
  if vim.fn.has('osx') == 1 then
    helios = macos.setup
  elseif vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    helios = windows.setup
  elseif vim.fn.executable('gdbus') == 1 then
    helios = gdbus.setup
  end
  helios(sunrise, sunset)
end

return M
