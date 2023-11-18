# inlay-hints.nvim

A plugin to simplify enabling neovim offical [inlay hints](https://github.com/neovim/neovim/pull/23426)

## Installation

Add `MysticalDevil/inlay-hints.nvim` using your favorite plugin manager, like this:

[lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
require("lazy").setup({
    "MysticalDevil/inlay-hints.nvim",
    event = "LspAttach",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
        require("inlay-hints").setup()
    end
})
```

[pckr.nvim](https://github.com/lewis6991/pckr.nvim)

```lua
require("pckr").add({
    "MysticalDevil/inlay-hints.nvim",
    requires = { "neovim/nvim-lspconfig" },
    config = function()
        require("inlay-hints").setup()
    end
})
```

If you don't want to enable it globally, you can config at the `on_attach` function

**on_attach**

```lua
require("lspconfig").[server_name].setup({
  on_attach = function(client, bufnr)
    require("inlay-hints").on_attach(client, bufnr)
  end
})
```

## Configuration

### Default config

You only need to pass the options you want to override.

```lua
require("inlay-hints").setup({
  commands = { enable = true } -- Enable InlayHints commands, include `InlayHintsToggle`, `InlayHintsEnable` and `InlayHintsDisable`
  autocmd = { enable = true } -- Enable the inlay hints on `LspAttach` event
})
```

## Languages

The inlay hints is not enabled by default, so you need the following settings, use [`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig)

> > You should make sure that the LSP you are using supported inlay hints

### lua_ls

Here's how to enable inlay hints for [`lua-language-server`](https://github.com/LuaLS/lua-language-server)

```lua
require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      hint = {
        enable = true, -- necessary
      }
    }
  }
})
```

### clangd

If you're using `p00f/clangd_extensions.nvim`, please set `autoSetHints = false`

Here's how to enable inlay hints for [`clangd`](https://github.com/clangd/clangd)

```lua
require("lspconfig").clangd.setup({
  settings = {
    clangd = {
      InlayHints = {
        Designators = true,
        Enabled = true,
        ParameterNames = true,
        DeducedTypes = true,
      },
      fallbackFlags = { "-std=c++20" },
    },
  }
})
```

### gopls

Here's how to enable inlay hints for [`gopls`](https://pkg.go.dev/golang.org/x/tools/gopls)

```lua
require("lspconfig").gopls.setup({
  settings = {
    hints = {
      rangeVariableTypes = true,
      parameterNames = true,
      constantValues = true,
      assignVariableTypes = true,
      compositeLiteralFields = true,
      compositeLiteralTypes = true,
      functionTypeParameters = true,
    },
  }
})
```

### rust-alalyzer

If you're using `simrat39/rust-tools.nvim`, you can enable it like

```lua
require("rust-tools").setup({
  inlay_hints = {
    auto = false
  },
  server = {
    settings = {
      inlayHints = {
        bindingModeHints = {
          enable = false,
        },
        chainingHints = {
          enable = true,
        },
        closingBraceHints = {
          enable = true,
          minLines = 25,
        },
        closureReturnTypeHints = {
          enable = "never",
        },
        lifetimeElisionHints = {
          enable = "never",
          useParameterNames = false,
        },
        maxLength = 25,
        parameterHints = {
          enable = true,
        },
        reborrowHints = {
          enable = "never",
        },
        renderColons = true,
        typeHints = {
          enable = true,
          hideClosureInitialization = false,
          hideNamedConstructor = false,
        },
      },
    }
  }
})
```

Here's how to enable inlay hints for [`rust-analyzer`](https://github.com/rust-lang/rust-analyzer)

```lua
require("lspconfig").rust_analyzer.setup({
  settings = {
    inlayHints = {
      bindingModeHints = {
        enable = false,
      },
      chainingHints = {
        enable = true,
      },
      closingBraceHints = {
        enable = true,
        minLines = 25,
      },
      closureReturnTypeHints = {
        enable = "never",
      },
      lifetimeElisionHints = {
        enable = "never",
        useParameterNames = false,
      },
      maxLength = 25,
      parameterHints = {
        enable = true,
      },
      reborrowHints = {
        enable = "never",
      },
      renderColons = true,
      typeHints = {
        enable = true,
        hideClosureInitialization = false,
        hideNamedConstructor = false,
      },
    },
  }
})
```

### typescript-language-server(tsserver)

If you're using `pmizio/typescript-tools.nvim`, you enable it like this

```lua
require("typescript-tools").setup({
  settings = {
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayVariableTypeHintsWhenTypeMatchesName = false,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    }
  }
})
```

Here's how to enable inlay hints for [`tsserver`](<https://github.com/microsoft/TypeScript/wiki/Standalone-Server-(tsserver)>)

```lua
require("lspconfig").tsserver.setup({
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  }
})
```

### zls

Here's how to enable inlay hints for [`zls`](https://github.com/zigtools/zls)

```lua
require("lspconfig").zls.setup({
  settings = {
    zls = {
      enable_inlay_hints = true,
      inlay_hints_show_builtin = true,
      inlay_hints_exclude_single_argument = true,
      inlay_hints_hide_redundant_param_names = false,
      inlay_hints_hide_redundant_param_names_last_token = false,
    },
  }
})
```

### pylyzer

Here's how to enable inlay hints for [`pylyzer`](https://github.com/mtshiba/pylyzer)

```lua
require("lspconfig").pylyzer.setup({
  settings = {
    python = {
      inlayHints = true
    }
  }
})
```

### kotline-language-server

Here's how to enable inlay hints for [`kotlin-language-server`](https://github.com/fwcd/kotlin-language-server)

```lua
require("lspconfig").kotlin_language_server.setup({
  settings = {
    kotlin = {
      hints = {
        typeHints = true,
        parameterHints = true,
        chaineHints = true,
      },
    },
  }
})

```
