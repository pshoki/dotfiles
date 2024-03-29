return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        local neotree = require("neo-tree")

        neotree.setup({
            close_if_last_window = true,
            filesystem = {
                follow_current_file = {
                    enable = true,
                },
                filtered_items = {
                    never_show = {
                        ".git",
                    },
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },
            buffers = {
                follow_current_file = {
                    enable = true,
                },
            },
            default_component_configs = {
                indent = {
                    with_markers = false,
                },
            },
        })

        vim.keymap.set("n", "<leader>t", ":Neotree float<CR>")
    end,
}
