return {
    { "williamboman/mason.nvim" },

    { "williamboman/mason-lspconfig.nvim" },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "folke/neodev.nvim", opts = {} },
            {
                "j-hui/fidget.nvim",
                tag = "legacy",
                opts = {},
            },
        },
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "L3MON4D3/LuaSnip" },
        },
    },

    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "dev-v3",
        config = function()
            local lsp = require("lsp-zero").preset({})
            lsp.extend_lspconfig()

            lsp.on_attach(function(client, bufnr)
                local telescope_builtin = require("telescope.builtin")

                vim.keymap.set(
                    "n",
                    "<leader>h",
                    vim.lsp.buf.hover,
                    { buffer = bufnr, desc = "LSP: Hover" }
                )

                vim.keymap.set(
                    "n",
                    "gd",
                    vim.lsp.buf.definition,
                    { buffer = bufnr, desc = "LSP: Go to definition" }
                )

                vim.keymap.set(
                    "n",
                    "gD",
                    vim.lsp.buf.declaration,
                    { buffer = bufnr, desc = "LSP: Go to declaration" }
                )

                vim.keymap.set(
                    "n",
                    "gI",
                    vim.lsp.buf.implementation,
                    { buffer = bufnr, desc = "LSP: Go to implementation" }
                )

                vim.keymap.set("n", "gr", function()
                    telescope_builtin.lsp_references({
                        show_line = false,
                    })
                end, {
                    buffer = bufnr,
                    desc = "LSP: Go to references",
                })

                vim.keymap.set(
                    "n",
                    "<leader>D",
                    vim.lsp.buf.type_definition,
                    { buffer = bufnr, desc = "LSP: Go to type definition" }
                )

                vim.keymap.set(
                    "n",
                    "<leader>ds",
                    vim.lsp.buf.document_symbol,
                    { buffer = bufnr, desc = "LSP: Document symbols" }
                )

                vim.keymap.set(
                    "n",
                    "<leader>ws",
                    vim.lsp.buf.workspace_symbol,
                    { buffer = bufnr, desc = "LSP: Workspace symbols" }
                )

                vim.keymap.set(
                    "n",
                    "<leader>rn",
                    vim.lsp.buf.rename,
                    { buffer = bufnr, desc = "LSP: Rename" }
                )

                vim.keymap.set(
                    "n",
                    "<leader>ca",
                    vim.lsp.buf.code_action,
                    { buffer = bufnr, desc = "LSP: Code action" }
                )
            end)

            lsp.format_mapping("f", {
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = {
                    ["null-ls"] = {
                        "javascript",
                        "typescript",
                        "typescriptreact",
                        "lua",
                        "json",
                        "jsonc",
                    },
                },
            })

            lsp.extend_cmp()

            require("mason").setup({
                ensure_installed = {
                    "prettier",
                    "stylua",
                },
            })
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "tsserver",
                    "lua_ls",
                    "eslint",
                    "jsonls",
                },
                handlers = {
                    lsp.default_setup,
                },
            })

            local cmp = require("cmp")
            local cmp_action = require("lsp-zero").cmp_action()

            cmp.setup({
                sources = {
                    { name = "copilot" },
                    { name = "nvim_lsp" },
                },
                mapping = {
                    ["<Tab>"] = cmp_action.luasnip_supertab(),
                    ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                },
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                },
            })
        end,
    },
}
