return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "ts_ls", "clangd", "pylsp", "jdtls" }
            })
        end
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        config = function()
            require('mason-tool-installer').setup({
                -- Install these linters, formatters, debuggers automatically
                ensure_installed = {
                    'java-debug-adapter',
                    'java-test',
                },
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_nvim_lsp.default_capabilities()
            )
            local attach = function(client, bufnr)
            end
            local lspconfig = require("lspconfig")

            require('mason-lspconfig').setup_handlers({
                function(server_name)
                    -- Don't call setup for JDTLS Java LSP because it will be setup from a separate config
                    if server_name ~= 'jdtls' then
                        lspconfig[server_name].setup({
                            on_attach = attach,
                            capabilities = capabilities,
                        })
                    end
                end
            })

            lspconfig.lua_ls.setup({
                capabilities = capabilities
            })
            lspconfig.ts_ls.setup({
                capabilities = capabilities
            })
            lspconfig.clangd.setup({
                capabilities = capabilities
            })
            lspconfig.pylsp.setup({
                capabilities = capabilities
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<leader>fg", vim.lsp.buf.format, {})
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
        end
    }
}
