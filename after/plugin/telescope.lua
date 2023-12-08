local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pfi', builtin.find_files, {})
vim.keymap.set('n', '<leader>pfa', function()
    builtin.find_files({ no_ignore = true, hidden = true })
end)
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>psi', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>psa', function()
    builtin.grep_string({
        search = vim.fn.input("Grep > "),
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '-u' -- disregard gitignore
        },
    })
end)

require('telescope').setup({
    defaults = {
        -- It's possible that telescope was freezing during fuzzy search,
        -- because of treesitter. This configuration disables it for the
        -- languages specified.
        -- https://github.com/nvim-telescope/telescope.nvim/pull/1612
        preview = {
            treesitter = false,
            languages = { "javascript", "php", "html" }
        },
    },
})
