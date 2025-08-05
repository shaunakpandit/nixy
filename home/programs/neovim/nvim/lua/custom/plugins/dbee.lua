return {
  'kndndrj/nvim-dbee',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  build = function()
    -- Install tries to automatically detect the install method.
    -- if it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require('dbee').install()
  end,
  config = function()
    require('dbee').setup {
      sources = {
        require('dbee.sources').EnvSource:new 'DBEE_CONNECTIONS',
        -- require("dbee.sources").MemorySource:new({
        --   {
        --     id = "localThea",
        --     name = "local",
        --     type = "mysql",
        --     url = "root:admin123@tcp(localhost:3306)/testlit_new",
        --     -- url = "jdbc:mysql://root:admin123@localhost:3306/testlit_new",
        --   },
        -- }),
      },
    }
  end,
}
