-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = false })
vim.api.nvim_set_keymap("v", "jk", "<Esc>", { noremap = false })

-- quatro
vim.keymap.set("n", "<leader>op", ":QuartoPreview<CR>", { silent = true, noremap = true })

local runner = require("quarto.runner")
vim.keymap.set("n", "<leader>Rc", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set("n", "<leader>rca", runner.run_above, { desc = "run cell and above", silent = true })
vim.keymap.set("n", "<leader>ra", runner.run_all, { desc = "run all cells", silent = true })
vim.keymap.set("n", "<leader>rl", runner.run_line, { desc = "run line", silent = true })
vim.keymap.set("v", "<leader>r", runner.run_range, { desc = "run visual range", silent = true })
vim.keymap.set("n", "<leader>RA", function()
  runner.run_all(true)
end, { desc = "run all cells of all languages", silent = true })

-- Molten

vim.keymap.set("n", "<leader>mi", function()
  local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
  if venv ~= nil then
    -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
    venv = string.match(venv, "/.+/(.+)")
    vim.cmd(("MoltenInit %s"):format(venv))
  else
    vim.cmd("MoltenInit python3")
  end
end, { desc = "Initialize Molten for python3", silent = true })

vim.keymap.set("n", "<leader>os", ":noautocmd MoltenEnterOutput<CR>", { silent = true, desc = "show/enter output" })

-- dbee
-- vim.keymap.set("n", "<leader>db", ":lua require('dbee').open()<CR>", { silent = true, noremap = true })

-- Typr
-- vim.keymap.set("n", "<leader>tp", ":Typr<CR>", { silent = true, noremap = true })

-- files
vim.api.nvim_set_keymap("n", "QQ", ":q!<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "WW", ":w!<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "E", "$", { noremap = false })
vim.api.nvim_set_keymap("n", "B", "^", { noremap = false })
vim.api.nvim_set_keymap("n", "TT", ":TransparentToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "ss", ":noh<CR>", { noremap = true })

-- Quicker close split
vim.keymap.set("n", "<leader>qq", ":q<CR>", { silent = true, noremap = true })

-- Obsidian Keymaps
vim.keymap.set("n", "<leader>on", ":ObsidianNewFromTemplate<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>od", ":ObsidianToday<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>ot", ":ObsidianTemplate<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>otc", ":ObsidianTOC<CR>", { silent = true, noremap = true })

-- Function to open Obsidian daily note in a floating window
local function SpawnDailyNoteWindow()
  -- Set the directory to your Obsidian folder
  local obsidian_dir = vim.fn.expand("~") .. "~/GithubMe/Brain2"

  -- Change to the Obsidian directory
  vim.cmd("lcd " .. vim.fn.fnameescape(obsidian_dir))

  -- Create a floating window
  local buf = vim.api.nvim_create_buf(false, true) -- Create a new buffer
  local ui = vim.api.nvim_list_uis()[1] -- Get UI dimensions

  local width = math.floor(ui.width * 0.8) -- Window width (80% of editor)
  local height = math.floor(ui.height * 0.8) -- Window height (80% of editor)
  local col = math.floor((ui.width - width) / 2) -- Center the window horizontally
  local row = math.floor((ui.height - height) / 2) -- Center the window vertically

  -- Window options
  local opts = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    anchor = "NW",
    style = "minimal",
    border = "rounded",
  }

  -- Open the floating window
  vim.api.nvim_open_win(buf, true, opts)

  -- Run the :ObsidianToday command to open the daily note
  vim.cmd("ObsidianToday")
end

-- Map the function to <leader>n
vim.keymap.set("n", "<leader>z", SpawnDailyNoteWindow, { noremap = true, silent = true })

-- CodeCompanion keymappings
vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionChat<CR>", { desc = "Chat" })
vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionActions<CR>", { desc = "Actions" })
vim.keymap.set("n", "<leader>ae", "<cmd>CodeCompanion /explain<CR>", { desc = "Explain" })
vim.keymap.set("n", "<leader>af", "<cmd>CodeCompanion /fixcode<CR>", { desc = "Fix Code" })
vim.keymap.set("v", "<leader>af", "<cmd>CodeCompanion /fixcode<CR>", { desc = "Fix Code" })
