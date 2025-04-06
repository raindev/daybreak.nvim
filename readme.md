# daybreak.nvim

A Neovim Lua plugin that matches the colorscheme background with the system dark/light appearance.

## Set-Up

When using [lazy.nvim](https://github.com/folke/lazy.nvim) just include `raindev/daybreak.nvim` into the list of plugins:

```lua
    'raindev/daybreak.nvim'
```

With different light and dark themes (make sure you don't also set
`colorscheme` in your configuration to avoid conflicts):

``` lua
{
  'raindev/daybreak.nvim',
  opts = {
	 light = 'github_light_default',
	 dark = 'github_dark_default',
  }
}
```

Using any other plugin manager add `raindev/daybreak.nvim` and load the plugin with

```lua
require('daybreak').setup({
   light = 'github_light_default',
   dark = 'github_dark_default',
})
```

## Goals

1. Immediately pick up appearance changes.
   - [x] Linux
   - [x] macOS
   - [ ] windows
2. Event based, no polling.
3. Support Linux, macOS and Windows.
4. Zero configuration required.
