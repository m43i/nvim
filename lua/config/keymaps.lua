vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })

-- move up down with cursor in middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- just do it
vim.keymap.set("n", "Q", "<nop>")

-- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- paste without loosing buffer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- format
-- vim.keymap.set({ "n", "v" }, "<leader>f", vim.lsp.buf.format)

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- conform format
-- vim.keymap.set({ "n", "v" }, "<leader>cf", ":lua require('conform').format()<CR>")
