return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",

        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },

        config = function()
            require("neo-tree").setup({
                sources = { "filesystem" },
                window = {
                    position = "left",
                },
                filesystem = {
                    filtered_items = {
                        visible = true,
                        hide_dotfiles = false,
                    },
                },
            })

            vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle left<CR>", {
                desc = "Toggle Neo-tree",
                silent = true,
            })
        end,
    },
}
