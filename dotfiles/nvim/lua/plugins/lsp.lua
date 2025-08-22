return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim",          config = true },
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "pyright", "clangd" },
        automatic_installation = true,
      })

      local lspconfig    = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- buffer-local mappings for LSP functionality
      local on_attach    = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
        map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>ld", vim.diagnostic.open_float, "Line Diagnostics")
        map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
        -- Format document with <leader>fm
        map("n", "<leader>fm", function()
          vim.lsp.buf.format({ async = true })
        end, "Format Document")
      end

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach    = on_attach,
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach    = on_attach,
      })

      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach    = on_attach,
      })

      lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach    = on_attach,
      })


      vim.diagnostic.config({
        virtual_text     = {
          prefix  = "",
          spacing = 2,
        },
        signs            = true,
        underline        = true,
        update_in_insert = false,
        severity_sort    = true,
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"]   = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"]    = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
