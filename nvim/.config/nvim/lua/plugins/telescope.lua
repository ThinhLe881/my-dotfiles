return {
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        config = function()
            local file_ignore_patterns = { ".git", "venv", "env", "__pycache__", "node_modules" }

            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = file_ignore_patterns
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        theme = "ivy"
                    },
                    live_grep = {
                        file_ignore_patterns = file_ignore_patterns,
                        additional_args = function(_)
                            return { "--hidden" }
                        end,
                        theme = "ivy"
                    },
                    buffers = {
                        theme = "ivy"
                    }
                },
                extensions = {
                    "fzf"
                }
            })
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<C-p>", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fc", function()
                builtin.find_files {
                    cwd = vim.fn.stdpath("config")
                }
            end)
            vim.keymap.set("n", "<C-f>", builtin.live_grep, {})
            vim.keymap.set("n", "<leader><leader>", builtin.buffers, {})

            require("telescope").load_extension("fzf")
            require("telescope").load_extension("ui-select")
        end
    }
}
