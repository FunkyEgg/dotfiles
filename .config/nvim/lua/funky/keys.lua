vim.g.mapleader = " "

-- Normal mode keymap
vim.keymap.set("n", "<leader>fn", vim.cmd.Ex) -- File:Netrw
vim.keymap.set("n", "<A-Up>", "<CMD>m -2<CR>") -- Move up
vim.keymap.set("n", "<A-Down>", "<CMD>m +1<CR>") -- Move down
