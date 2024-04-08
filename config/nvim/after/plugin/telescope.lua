--print("after ts is loaded")
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
--vim.keymap.set('n', '<leader>fs', function() builtin.grep_string({ search = vim.fn.input("Grep For > ")}) end)
vim.keymap.set('n', '<leader>fs', function() vim.ui.input({prompt = ' Grep > '}, function(value) require('telescope.builtin').grep_string({search = value}) end) end)
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
