return {
  'olimorris/codecompanion.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'ravitemer/mcphub.nvim',
  },
  opts = {
    extensions = {
      mcphub = {
        callback = 'mcphub.extensions.codecompanion',
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
    },
    strategies = {
      chat = {
        adapter = {
          name = 'openai',
          model = 'gpt-4.1',
        },
        keymaps = {
          options = {
            modes = { n = '?' },
            callback = function()
              require('which-key').show { global = false }
            end,
            description = 'Codecompanion Keymaps',
            hide = true,
          },
        },
      },
      inline = {
        adapter = 'openai',
      },
    },
  },
}
-- config: https://codecompanion.olimorris.dev/
