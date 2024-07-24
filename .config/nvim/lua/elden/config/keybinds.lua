vim.keymap.set('n', '-', "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
