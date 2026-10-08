require("config.options")
require("config.keymaps")
require("config.neomd")
require("config.lazy")
require("config.lsp")
require("config.transparency")
vim.cmd.colorscheme("rose-pine")
vim.api.nvim_set_hl(0, "CursorLineNr", {
    fg = "#ffff00",
    bold = true,
})

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
vim.api.nvim_set_hl(0, "Visual", {
    fg = "#ffffff",
    bg = "#666666",
})
vim.keymap.set("n", "<F5>", ":!python %<CR>", { desc = "Run Python file" })

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
