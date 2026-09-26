vim.g.mapleader = " "

local map = vim.keymap.set

map("n", "<leader>w", "<cmd>w<CR>")
map("n", "<leader>q", "<cmd>q<CR>")

map("n", "<Esc>", "<cmd>noh<CR><Esc>")

map("n", "<leader>h", "<C-w>h")
map("n", "<leader>j", "<C-w>j")
map("n", "<leader>k", "<C-w>k")
map("n", "<leader>l", "<C-w>l")

map("n", "<C-Up>", "<cmd>resize +2<CR>")
map("n", "<C-Down>", "<cmd>resize -2<CR>")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")
