return {
  'nvim-neorg/neorg',

  build = 'Neorg sync-parsers',
  lazy = false,
  version = '*',
  config = function()
    require('neorg').setup {
      load = {
        ['core.defaults'] = {},
        ['core.keybinds'] = {
          config = {
            vim.api.nvim_create_autocmd('FileType', {
              pattern = 'norg',
              callback = function()
                vim.keymap.set('n', '<localleader>s', ':Neorg generate-workspace-summary<CR>', { buffer = true })
              end,
            }),
            vim.keymap.set('n', '<localleader>ni', ':Neorg index <CR>', {}),
          },
        },
        ['core.summary'] = {},
        ['core.concealer'] = {},
        ['core.dirman'] = {
          config = {
            workspaces = {
              notes = '~/notes',
            },
            default_workspace = 'notes',
          },
        },
      },
    }

    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
}
