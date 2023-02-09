local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- It's possible that telescope was freezing during fuzzy search,
-- because of treesitter. This configuration disables it for the
-- languages specified.
-- https://github.com/nvim-telescope/telescope.nvim/pull/1612
require('telescope').setup({
    defaults = {
        preview = {
            treesitter = false,
            languages = { "javascript", "php", "html" }
        },
    },
})
