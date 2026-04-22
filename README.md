# inlay-hints.nvim

A minimal Neovim plugin that simplifies enabling Neovim's **official LSP inlay hints**.

> [!IMPORTANT]
> This is intentionally a **very simple plugin**. It only provides a thin wrapper around `vim.lsp.inlay_hint` and collects LSP-specific configuration examples.
>
> **You do not need to install this plugin** to use inlay hints. Neovim has built-in support since 0.10+. The most valuable part of this repo is the [LSP Server Configuration](#lsp-server-configuration) section below — you can copy those server settings directly into your own config.

---

## Requirements

- Neovim **0.10+**
- An LSP server that **supports inlay hints**
- [`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig) (optional, but recommended for examples)

---

## Installation

Install `MysticalDevil/inlay-hints.nvim` with your preferred plugin manager.

### lazy.nvim

```lua
require("lazy").setup({
  {
    "MysticalDevil/inlay-hints.nvim",
    event = "LspAttach",
    dependencies = { "neovim/nvim-lspconfig" }, -- optional
    config = function()
      require("inlay-hints").setup()
    end,
  },
})
```

### vim.pack (Neovim 0.12+ built-in)

```lua
vim.pack.add({
  { src = 'https://github.com/MysticalDevil/inlay-hints.nvim' },
})

require("inlay-hints").setup()
```

---

## Manual Setup (Without This Plugin)

If you prefer to keep your config dependency-free, you can achieve the same behavior with a few lines of Lua:

```lua
-- Auto-enable inlay hints on LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

-- User commands
vim.api.nvim_create_user_command("InlayHintsToggle", function()
  vim.lsp.inlay_hint.enable(
    not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }),
    { bufnr = 0 }
  )
end, {})

vim.api.nvim_create_user_command("InlayHintsEnable", function()
  vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
end, {})

vim.api.nvim_create_user_command("InlayHintsDisable", function()
  vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
end, {})
```

Then jump straight to the [LSP Server Configuration](#lsp-server-configuration) section to see how to enable hints for your language server.

---

## Usage

### Enable per LSP (recommended)

If you don’t want to enable inlay hints globally, attach them manually in your LSP `on_attach` function:

```lua
vim.lsp.config("lua_ls", {
  on_attach = function(client, bufnr)
    require("inlay-hints").on_attach(client, bufnr)
  end,
})
```

---

## Configuration

Only override the options you need.

### Default configuration

```lua
require("inlay-hints").setup({
  commands = { enable = true }, -- Enable commands: InlayHintsToggle, InlayHintsEnable, InlayHintsDisable
  autocmd = { enable = true },  -- Auto-enable inlay hints on LspAttach
})
```

---

## LSP Server Configuration

Inlay hints are **disabled by default** in most LSP servers. You must explicitly enable them in the server settings.

> See [`docs/lsp-configurations.md`](docs/lsp-configurations.md) for a complete list of supported LSP servers with full configuration examples.

---

## License

Apache 2.0

