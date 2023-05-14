# daybreak.nvim

A Neovim Lua plugin that matches the colorscheme background with the system dark/light appearance.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

    { 'raindev/daybreak.nvim', config = true }

Using any other plugin manager add `raindev/daybreak.nvim` and load the plugin with `require('daybreak').setup()`.

## Goals

1. Immediately pick up appearance changes.
   - [x] Linux
   - [ ] macOS
   - [ ] windows
2. Event based, no polling.
3. Lua, minimal external dependencies.
   - not there yet
4. Support Linux, macOS and Windows (planned).
5. Zero configuration.
