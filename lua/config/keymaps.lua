vim.g.mapleader = " "

local map = vim.keymap.set

map("n", "<leader>w", "<cmd>w<CR>")
map("n", "<leader>q", "<cmd>q<CR>")

map("n", "<leader>e", function()
    local netrw_win = nil
    for _, w in ipairs(vim.api.nvim_list_wins()) do
        if vim.bo[vim.api.nvim_win_get_buf(w)].filetype == "netrw" then
            netrw_win = w
            break
        end
    end
    if netrw_win then
        if #vim.api.nvim_list_wins() > 1 then
            vim.api.nvim_win_close(netrw_win, true)
        else
            vim.cmd("enew")
        end
        return
    end
    vim.cmd("Explore")
end, { desc = "Toggle netrw" })

map("n", "<Esc>", "<cmd>noh<CR><Esc>")

map("n", "<leader>h", "<C-w>h")
map("n", "<leader>j", "<C-w>j")
map("n", "<leader>k", "<C-w>k")
map("n", "<leader>l", "<C-w>l")

map("n", "<C-Up>", "<cmd>resize +2<CR>")
map("n", "<C-Down>", "<cmd>resize -2<CR>")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "J", "mzJ`z")

vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.api.nvim_set_hl(0, "CursorLineNetrw", { bg = "#2a2d42" })
        vim.wo.cursorline = true
        vim.wo.cursorlineopt = "line"
        vim.wo.winhighlight = "CursorLine:CursorLineNetrw"
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.wo.signcolumn = "no"
    end,
})

map("x", "<leader>p", '"_dP')

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
