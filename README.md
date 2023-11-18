# inlay-hints.nvim

A plugin to simplify enabling neovim offical [inlay hints](https://github.com/neovim/neovim/pull/23426)

## Installation

Add `MysticalDevil/inlay-hints.nvim` using your favorite plugin manager, like this:

[lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
require("lazy").setup({
    "MysticalDevil/inlay-hints.nvim",
    config = function()
        require("inlay-hints").setup()
    end
})
```

[pckr.nvim](https://github.com/lewis6991/pckr.nvim)

```lua
require("pckr").add({
    "MysticalDevil/inlay-hints.nvim",
    config = function()
        require("inlay-hints").setup()
    end
})
```
