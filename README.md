# inlay-hints.nvim

A plugin to simplify enabling neovim offical [inlay hints](https://github.com/neovim/neovim/pull/23426)

> [!IMPORTANT]
> This is a VERY SIMPLE plugin. I just integrated how to enable the inlay hint of each LSP.

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

### denols

Here's how to enable inlay hints for [`denols`](https://github.com/denoland/deno/blob/main/cli/lsp)

```lua
require("lspconfig").denols.setup({
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
    }
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

### rust-analyzer

If you're using `mrcjkb/rustaceanvim`, you can enable it like

```lua
vim.g.rustaceanvim = {
  server = {
    settings = {
      ["rust-analyzer"] = {
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
      },
    },
  },
}
```

Here's how to enable inlay hints for [`rust-analyzer`](https://github.com/rust-lang/rust-analyzer)

```lua
require("lspconfig").rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
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

### typescript-language-server (tsserver)

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

### svelte-language-server

Here's how to enable inlay hints for [`svelte-language-server`](https://github.com/sveltejs/language-tools)

```lua
require('lspconfig').svelte.setup {
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = 'all' },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}
```

### vtsls

Here's how to enable inlay hints for [`vtsls`](https://github.com/yioneko/vtsls)

> contribute by [`lucicoreyli`](https://github.com/lucioreyli)

```lua
require('lspconfig').vtsls.setup {
  -- capabilities = capabilities,
  -- flags = lsp_flags,
  -- on_attach = on_attach,
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = 'all' },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}
```

>>>>>>> c9eae1e (chore: Add vtsls config doc)
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

### basedpyright

Here's how to enable inlay hints for [`basedpyright`](https://github.com/DetachHead/basedpyright)
When you configure inlay hint correctly, the basedpyright's feature will be automatically enabled.

```lua
required('lspconfig').basedpyright.setup({
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true
      }
    }
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

### kotlin-language-server

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

### eclipse.jdt.ls

Here's how to enable inlay hints for [`eslipse.jdt.ls`](https://github.com/eclipse-jdtls/eclipse.jdt.ls)

```lua
require("lspconfig").jdtls.setup({
  settings = {
    java = {
      inlayHints = {
        parameterNames = {
          enabled = "all",
          exclusions = { "this" },
        },
      },
    }
  }
})
```

### OmniSharp

Here's how to enable inlay hints for [`OmniSharp`](https://github.com/OmniSharp/omnisharp-roslyn)
~~might work~~

```lua
require("lspconfig").omnisharp.setup({
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
        ForImplicitObjectCreatio = true,
      },
    },
  }
})
```
