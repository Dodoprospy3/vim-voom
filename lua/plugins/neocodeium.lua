return {
    {
        "monkoose/neocodeium",
        event = "VeryLazy",
        config = function()
            local neocodeium = require("neocodeium")
            local blink = require("blink.cmp")

            neocodeium.setup({
                show_label = false,
                silent = false,
                filter = function()
                    return not blink.is_visible()
                end,
            })

            vim.keymap.set("i", "<C-y>", function()
                if neocodeium.visible() and not blink.is_visible() then
                    neocodeium.accept()
                else
                    return "<C-y>"
                end
            end, { expr = true, desc = "Accept AI suggestion" })

            vim.keymap.set("i", "<C-n>", function()
                if neocodeium.visible() and not blink.is_visible() then
                    neocodeium.clear()
                else
                    return "<C-n>"
                end
            end, { expr = true, desc = "Reject AI suggestion" })

            vim.api.nvim_create_autocmd("User", {
                pattern = "BlinkCmpMenuOpen",
                callback = function()
                    neocodeium.clear()
                end,
            })
        end,
    },
}
