# inlay-hints.nvim

A minimal Neovim plugin that simplifies enabling Neovim's **official LSP inlay hints**.

It provides a small wrapper around the built-in inlay hints support introduced in Neovim `0.11+`, making it easier to toggle and auto-enable hints per LSP.

> [!IMPORTANT]
> This is intentionally a **very simple plugin**. It only integrates how inlay hints are enabled for different LSP servers.
> If you prefer full manual control, you may want to configure inlay hints directly in your Neovim setup instead.

---

## Requirements

- Neovim **0.11+**
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

### pckr.nvim

```lua
require("pckr").add({
  "MysticalDevil/inlay-hints.nvim",
  requires = { "neovim/nvim-lspconfig" }, -- optional
  config = function()
    require("inlay-hints").setup()
  end,
})
```

---

## Usage

### Enable per LSP (recommended)

If you don’t want to enable inlay hints globally, attach them manually in your LSP `on_attach` function:

```lua
require("lspconfig")[server_name].setup({
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

> Make sure the LSP server you are using actually supports inlay hints.

Below is a complete list of supported / commonly used LSP servers with **explicit source links** and example configurations.

---

### lua_ls

Source: https://github.com/LuaLS/lua-language-server

```lua
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      hint = { enable = true },
    },
  },
})
```

---

### clangd

Source: https://github.com/clangd/clangd
Extension: https://github.com/p00f/clangd_extensions.nvim

> If you use `clangd_extensions.nvim`, set `autoSetHints = false`.

```lua
vim.lsp.config("clangd", {
  settings = {
    clangd = {
      InlayHints = {
        Enabled = true,
        ParameterNames = true,
        DeducedTypes = true,
        Designators = true,
      },
      fallbackFlags = { "-std=c++20" },
    },
  },
})
```

---

### denols

Source: https://github.com/denoland/deno/tree/main/cli/lsp

```lua
vim.lsp.config("denols", {
  settings = {
    deno = {
      inlayHints = {
        parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true, suppressWhenTypeMatchesName = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enable = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
})
```

---

### gopls

Source: https://pkg.go.dev/golang.org/x/tools/gopls

```lua
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      hints = {
        rangeVariableTypes = true,
        parameterNames = true,
        constantValues = true,
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        functionTypeParameters = true,
      },
    },
  },
})
```

---

### rust-analyzer

Source: https://github.com/rust-lang/rust-analyzer

```lua
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      inlayHints = {
        chainingHints = { enable = true },
        closingBraceHints = { enable = true, minLines = 25 },
        parameterHints = { enable = true },
        typeHints = { enable = true },
      },
    },
  },
})
```

*If you're still using Rustacest Vim as your Rust tooling and have installed mason.nvim and mason-lspconfig.nvim, you can refer to the following configuration*

To prevent duplicate launches of rust-analyzer instances by rustaceanvim (ftplugin) and mason-lspconfig, exclude this Server from the latter's configuration.
```lua
require("mason-lspconfig").setup({
  automatic_enable = {
    exclude = {
      "rust_analyzer",
    },
  },
})
```

Configure the following in lazy.nvim for rustaceanvim:
```lua
{
  "mrcjkb/rustaceanvim",
  version = "^7", -- Recommended
  ft = { "rust" },
  lazy = false,
  init_option = function()
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            inlayHints = {
              chainingHints = { enable = true },
              closingBraceHints = { enable = true, minLines = 25 },
              parameterHints = { enable = true },
              typeHints = { enable = true },
            },
          },
        },
      },
    }
  end,
}
```

---

### tsserver (typescript-language-server)

Source: https://github.com/microsoft/TypeScript/wiki/Standalone-Server-(tsserver)

```lua
vim.lsp.config("tsserver", {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})
```

---

### tsgo

Source: https://github.com/microsoft/typescript-go

```lua
vim.lsp.config("tsgo", {
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
})
```

---

### svelte-language-server

Source: https://github.com/sveltejs/language-tools

```lua
vim.lsp.config("svelte", {
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
})
```

---

### vtsls

Source: https://github.com/yioneko/vtsls

```lua
vim.lsp.config("vtsls", {
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
})
```

---

### zls

Source: https://github.com/zigtools/zls

```lua
vim.lsp.config("zls", {
  settings = {
    zls = {
      enable_inlay_hints = true,
      inlay_hints_show_builtin = true,
      inlay_hints_exclude_single_argument = true,
      inlay_hints_hide_redundant_param_names = false,
      inlay_hints_hide_redundant_param_names_last_token = false,
    },
  },
})
```

---

### basedpyright

Source: https://github.com/DetachHead/basedpyright

```lua
vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      },
    },
  },
})
```

---

### ty

Source: https://github.com/astral-sh/ty

```lua
vim.lsp.config("ty", {
  settings = {
    ty = {
      inlayHints = {
        variableTypes = true,
        callArgumentNames = true,
      },
    },
  },
})
```

---

### pylyzer

Source: https://github.com/mtshiba/pylyzer

```lua
vim.lsp.config("pylyzer", {
  settings = {
    python = {
      inlayHints = true,
    },
  },
})
```

---

### kotlin-language-server

Source: https://github.com/fwcd/kotlin-language-server

```lua
vim.lsp.config("kotlin_language_server", {
  settings = {
    kotlin = {
      hints = {
        typeHints = true,
        parameterHints = true,
        chainHints = true,
      },
    },
  },
})
```

---

### eclipse.jdt.ls

Source: https://github.com/eclipse-jdtls/eclipse.jdt.ls

```lua
vim.lsp.config("jdtls", {
  settings = {
    java = {
      inlayHints = {
        parameterNames = {
          enabled = "all",
          exclusions = { "this" },
        },
      },
    },
  },
})
```


---

### OmniSharp

Source: https://github.com/OmniSharp/omnisharp-roslyn

> Experimental / may vary by version

```lua
vim.lsp.config("omnisharp", {
  settings = {
    RoslynExtensionsOptions = {
      InlayHintsOptions = {
        EnableForParameters = true,
        ForLiteralParameters = true,
        ForIndexerParameters = true,
        ForObjectCreationParameters = true,
        ForOtherParameters = true,
        SuppressForParametersThatDifferOnlyBySuffix = false,
        SuppressForParametersThatMatchMethodIntent = false,
        SuppressForParametersThatMatchArgumentName = false,
        EnableForTypes = true,
        ForImplicitVariableTypes = true,
        ForLambdaParameterTypes = true,
        ForImplicitObjectCreation = true,
      },
    },
  },
})
```

---

### Ruby LSP

Source: https://shopify.github.io/ruby-lsp

```lua
vim.lsp.config("ruby_lsp", {
  init_options = {
    featuresConfiguration = {
      inlayHint = {
        enableAll = true,
        implicitRescue = true,
        implicitHashValue = true,
      },
    },
  },
})
```

---
## License

Apache 2.0

