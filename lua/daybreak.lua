local gdbus = require('gdbus')
local macos = require('macos')

local M = {}

function M.setup(_)
  if vim.fn.has('osx') == 1 then
    macos.setup()
  elseif vim.fn.executable('gdbus') == 1 then
    gdbus.setup()
  end
end

return M
