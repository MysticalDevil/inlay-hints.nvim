## LSP Server Configuration

Inlay hints are **disabled by default** in most LSP servers. You must explicitly enable them in the server settings.

> Make sure the LSP server you are using actually supports inlay hints.

### Servers with Inlay Hints Enabled by Default

The following servers have inlay hints turned on **out of the box**. You only need to ensure your editor displays them (e.g. `vim.lsp.inlay_hint.enable(true, { bufnr = 0 })` in Neovim):

| Server | Language | Notes |
|--------|----------|-------|
| [basedpyright](#basedpyright) | Python | — |
| [fsautocomplete](#fsautocomplete) | F# | — |
| `haskell-language-server` | Haskell | No server-side toggle |
| `phpantom_lsp` | PHP | Experimental. Configured via `.phpantom.toml`, not LSP settings |

For all other servers, you must explicitly enable inlay hints in their settings — see below.

---

Below is a complete list of supported / commonly used LSP servers with **explicit source links** and example configurations.

---

## Lua

### lua_ls

Source: https://github.com/LuaLS/lua-language-server

```lua
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      hint = {
        enable = true,              -- Enable inlay hints globally
        paramName = "All",          -- Parameter name hints: "All" | "Literal" | "Disable"
        paramType = true,           -- Function parameter type hints
        setType = true,             -- Assignment type hints
        arrayIndex = "Auto",        -- Array index hints: "Enable" | "Auto" | "Disable"
        await = true,               -- Await hints
        semicolon = "All",          -- Semicolon hints: "All" | "SameLine" | "Disable"
      },
    },
  },
})
```

---

## JavaScript / TypeScript

### vtsls

Source: https://github.com/yioneko/vtsls

> ✅ **Recommended**. Wraps VS Code's TypeScript language service — richer features and better performance than `ts_ls`.

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

### tsgo

Source: https://github.com/microsoft/typescript-go

> Microsoft's next-gen TypeScript compiler rewritten in Go. Still in preview — APIs may change.

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

### tsserver (typescript-language-server)

Source: https://github.com/microsoft/TypeScript/wiki/Standalone-Server-(tsserver)

> ⚠️ **Legacy / not recommended**. Consider migrating to [`vtsls`](#vtsls) for better features and performance.

```lua
vim.lsp.config("ts_ls", {
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

### denols

Source: https://github.com/denoland/deno/tree/main/cli/lsp

```lua
vim.lsp.config("denols", {
  settings = {
    deno = {
      inlayHints = {
        parameterNames = {
          enabled = "all",                    -- "none" | "literals" | "all"
          suppressWhenArgumentMatchesName = true,
        },
        parameterTypes = { enabled = true },
        variableTypes = {
          enabled = true,
          suppressWhenTypeMatchesName = true,
        },
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

### vue_ls (Volar)

Source: https://github.com/vuejs/language-tools

> `vue_ls` is for **Vue 3** projects. Vue 2 is EOL and no longer supported.

Vue's language server does **not** provide inlay hints directly. Inlay hints for `.vue` files come from the TypeScript server (via `@vue/typescript-plugin`).

**Hybrid Mode (default, recommended)** — `vue_ls` handles template/CSS, while `vtsls` (or `ts_ls`) handles TypeScript. Enable the Vue plugin in `vtsls`:

```lua
vim.lsp.config("vtsls", {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = vim.fn.expand("~/.local/share/pnpm/global/5/node_modules/@vue/typescript-plugin"),
            languages = { "vue" },
            configNamespace = "typescript",
          },
        },
      },
    },
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
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})
```

**No Hybrid Mode** — `vue_ls` runs an embedded TypeScript server. Configure it the same way as `ts_ls`:

```lua
vim.lsp.config("vue_ls", {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  init_options = {
    vue = { hybridMode = false },
    typescript = { tsdk = vim.fn.expand("~/.local/share/pnpm/global/5/node_modules/typescript/lib") },
  },
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
  },
})
```

---

## Python

### basedpyright

Source: https://github.com/DetachHead/basedpyright

> Inlay hints are **enabled by default** in basedpyright. The configuration below is only needed if you want to customize specific hints.

```lua
vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        inlayHints = {
          variableTypes = true,              -- Variable type hints
          callArgumentNames = true,          -- Function argument name hints
          callArgumentNamesMatching = false, -- Show even when arg name matches param name
          functionReturnTypes = true,        -- Function return type hints
          genericTypes = true,               -- Inferred generic type hints
        },
      },
    },
  },
})
```

---

### ty

Source: https://github.com/astral-sh/ty

> Replaces `pylyzer`. The core developer of pylyzer ([@mtshiba](https://github.com/mtshiba)) has joined the `ty` project. `pylyzer` is no longer recommended.

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

## Go

### gopls

Source: https://pkg.go.dev/golang.org/x/tools/gopls

```lua
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = true,      -- Variable type hints in assignments
        compositeLiteralFields = true,   -- Composite literal field name hints
        compositeLiteralTypes = true,    -- Composite literal type hints
        constantValues = true,           -- Constant value hints (iota)
        functionTypeParameters = true,   -- Generic function type parameter hints
        ignoredError = true,             -- Implicitly discarded error hints (experimental)
        parameterNames = true,           -- Function call parameter name hints
        rangeVariableTypes = true,       -- Range statement variable type hints
      },
    },
  },
})
```

---

## C / C++

### clangd

Source: https://github.com/clangd/clangd
Extension: https://github.com/p00f/clangd_extensions.nvim

> If you use `clangd_extensions.nvim`, set `autoSetHints = false`.

clangd does **not** support configuring inlay hints via LSP `settings`.
Instead, create a `.clangd` file in your project root:

```yaml
InlayHints:
  Enabled: true              # Global enable/disable
  ParameterNames: true       # Parameter name hints in function calls
  DeducedTypes: true         # Deduced type hints
  Designators: true          # Aggregate initialization designators
  BlockEnd: false            # Block end comment hints
  DefaultArguments: false    # Default argument hints
  TypeNameLimit: 24          # Type hint character limit (0 = no limit)
```

---

## Rust

### rust-analyzer

Source: https://github.com/rust-lang/rust-analyzer

```lua
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      inlayHints = {
        -- Type related
        typeHints = { enable = true },                          -- Variable type hints
        chainingHints = { enable = true },                      -- Method chain type hints
        closureReturnTypeHints = { enable = "never" },          -- "never" | "always"
        closureCaptureHints = { enable = false },               -- Closure capture hints
        -- Parameter related
        parameterHints = { enable = true },                     -- Function parameter hints
        -- Brace related
        closingBraceHints = { enable = true, minLines = 25 },   -- Closing brace hints
        -- Other
        bindingModeHints = { enable = false },                  -- Binding mode hints
        discriminantHints = { enable = "never" },               -- Enum discriminant hints
        expressionAdjustmentHints = { enable = "never" },       -- Type adjustment hints
        implicitDrops = { enable = false },                     -- Implicit drop hints
        lifetimeElisionHints = { enable = "never" },            -- Lifetime elision hints
        genericParameterHints = {
          type = { enable = false },
          lifetime = { enable = false },
          const = { enable = false },
        },
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

## C#

### roslyn (official)

Source: https://github.com/dotnet/roslyn
Plugin: https://github.com/seblj/roslyn.nvim

> Replaces the discontinued OmniSharp. Used by the VS Code C# extension.
> Use `roslyn_ls` instead of `roslyn` if you are using native nvim-lspconfig without the `roslyn.nvim` plugin.

```lua
vim.lsp.config("roslyn", {
  settings = {
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
      csharp_enable_inlay_hints_for_lambda_parameter_types = true,
      csharp_enable_inlay_hints_for_types = true,
      dotnet_enable_inlay_hints_for_indexer_parameters = true,
      dotnet_enable_inlay_hints_for_literal_parameters = true,
      dotnet_enable_inlay_hints_for_object_creation_parameters = true,
      dotnet_enable_inlay_hints_for_other_parameters = true,
      dotnet_enable_inlay_hints_for_parameters = true,
      dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = false,
      dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = false,
      dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = false,
    },
  },
})
```

---

### OmniSharp (legacy)

Source: https://github.com/OmniSharp/omnisharp-roslyn

> Discontinued. Consider migrating to [roslyn](#roslyn-official).

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

## F#

### fsautocomplete

Source: https://github.com/fsharp/FsAutoComplete

> Inlay hints are **enabled by default** in fsautocomplete. The configuration below is only needed if you want to customize specific hints.

```lua
vim.lsp.config("fsautocomplete", {
  settings = {
    FSharp = {
      inlayHints = {
        enabled = true,           -- Master switch for inlay hints
        typeAnnotations = true,   -- Type annotation hints for bindings
        parameterNames = true,    -- Parameter name hints for functions/methods
      },
    },
  },
})
```

---

## Zig

### zls

Source: https://github.com/zigtools/zls

```lua
vim.lsp.config("zls", {
  settings = {
    zls = {
      enable_inlay_hints = true,                              -- Global enable
      inlay_hints_show_builtin = true,                        -- Show builtin function hints
      inlay_hints_show_parameter_name = true,                 -- Show parameter name hints
      inlay_hints_show_variable_type_hints = true,            -- Show variable type hints
      inlay_hints_show_struct_literal_field_type = true,      -- Show struct literal field type hints
      inlay_hints_exclude_single_argument = true,             -- Exclude single argument hints
      inlay_hints_hide_redundant_param_names = false,         -- Hide redundant parameter names
      inlay_hints_hide_redundant_param_names_last_token = false, -- Hide redundant param names for last token
    },
  },
})
```

---

## JVM

### eclipse.jdt.ls (Java)

Source: https://github.com/eclipse-jdtls/eclipse.jdt.ls

```lua
vim.lsp.config("jdtls", {
  settings = {
    java = {
      inlayHints = {
        parameterNames = {
          enabled = "all",                    -- "none" | "literals" | "all"
          exclusions = { "this" },
        },
        variableTypes = { enabled = true },   -- Variable type hints
        parameterTypes = { enabled = true },  -- Parameter type hints
      },
    },
  },
})
```

---

### kotlin-language-server (community)

Source: https://github.com/fwcd/kotlin-language-server

```lua
vim.lsp.config("kotlin_language_server", {
  settings = {
    kotlin = {
      hints = {
        typeHints = true,
        parameterHints = true,
        chainedHints = true,
      },
    },
  },
})
```

---

### kotlin-lsp (JetBrains official, pre-alpha)

Source: https://github.com/Kotlin/kotlin-lsp

> **Pre-alpha / experimental**. Based on IntelliJ IDEA. Currently only JVM-only Gradle projects are supported.

```lua
vim.lsp.config("kotlin", {
  settings = {
    ["jetbrains.kotlin.hints"] = {
      settings = {
        types = {
          property = true,    -- Property type hints
          variable = true,    -- Local variable type hints
        },
      },
      type = {
        ["function"] = {
          return = true,      -- Function return type hints
          parameter = true,   -- Function parameter type hints
        },
      },
      lambda = {
        receivers = {
          parameters = true,  -- Implicit receivers and parameters
        },
      },
      parameters = true,            -- Parameter names
      ["call.chains"] = false,      -- Function return type in call chains
    },
  },
})
```

---

### Metals (Scala)

Source: https://github.com/scalameta/metals

> All inlay hint options are **disabled by default**.

```lua
vim.lsp.config("metals", {
  settings = {
    ["inlay-hints"] = {
      ["inferred-types"] = { enable = true },           -- Inferred type annotations
      ["named-parameters"] = { enable = true },         -- Parameter names next to arguments
      ["by-name-parameters"] = { enable = true },       -- By-name parameter indicators (=>)
      ["implicit-arguments"] = { enable = true },       -- Implicit parameter hints
      ["implicit-conversions"] = { enable = true },     -- Implicit conversion hints
      ["type-parameters"] = { enable = true },          -- Type parameter annotations
      ["hints-in-pattern-match"] = { enable = true },   -- Type annotations in pattern matches
      ["hints-x-ray-mode"] = { enable = true },         -- Intermediate type annotations in multi-line chains
      ["closing-labels"] = { enable = true },           -- Closing label hints for braces
    },
  },
})
```

---

## Dart

### dartls (Dart Analysis Server)

Source: https://github.com/dart-lang/sdk/tree/main/pkg/analysis_server

```lua
vim.lsp.config("dartls", {
  settings = {
    dart = {
      inlayHints = {
        -- Enable all hints (shortcut)
        -- true  = all hints enabled with defaults
        -- false = all hints disabled
        -- Or configure individually:
        dotShorthandTypes = { enabled = true },   -- Dot shorthand type hints
        parameterNames = { enabled = "all" },     -- "none" | "literal" | "all"
        parameterTypes = { enabled = true },      -- Parameter type hints
        returnTypes = { enabled = true },         -- Return type hints
        typeArguments = { enabled = true },       -- Generic type argument hints
        variableTypes = { enabled = true },       -- Variable type hints
      },
    },
  },
})
```

---

## Others

### Ruby LSP

Source: https://shopify.github.io/ruby-lsp#inlay-hints

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

### ocamllsp (OCaml)

Source: https://github.com/ocaml/ocaml-lsp

> All inlay hint options are **disabled by default**.

```lua
vim.lsp.config("ocamllsp", {
  settings = {
    inlayHints = {
      hintLetBindings = true,      -- Type hints on let bindings
      hintPatternVariables = true, -- Type hints on pattern variables
      hintFunctionParams = true,   -- Type hints on function parameters (newer versions)
    },
  },
})
```

---

### intelephense (PHP)

Source: https://intelephense.com

> **Premium feature**. Inlay hints require a paid licence. They are **enabled by default** in the server settings, but will only be sent to the client if the licence is active.

```lua
vim.lsp.config("intelephense", {
  settings = {
    intelephense = {
      inlayHint = {
        returnTypes = true,     -- Function return type hints
        parameterTypes = true,  -- Anonymous function parameter type hints
        parameterNames = true,  -- Call argument parameter name hints
      },
    },
  },
})
```

---

### phpactor (PHP)

Source: https://github.com/phpactor/phpactor

> **Experimental**. Inlay hints are disabled by default for performance reasons.

```lua
vim.lsp.config("phpactor", {
  settings = {
    language_server_worse_reflection = {
      inlay_hints = {
        enable = true,  -- Master switch
        types = true,   -- Variable type hints
        params = true,  -- Parameter name hints
      },
    },
  },
})
```

---

### expert (Elixir)

Source: https://github.com/elixir-lang/expert

> **Not yet supported**. Expert is the official Elixir language server, currently in alpha. Inlay hints are not implemented yet — stay tuned for future updates.
