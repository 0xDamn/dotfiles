-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps hereby
--
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Function to create a recursive resize command
local function create_resize_command(resize_cmd)
  return function()
    vim.cmd(resize_cmd)
    local key = vim.fn.getchar()
    while key ~= 27 do  -- 27 is the ASCII code for Esc
      if key == 76 or key == 108 then  -- 'L' or 'l'
        vim.cmd("vertical resize +2")
      elseif key == 72 or key == 104 then  -- 'H' or 'h'
        vim.cmd("vertical resize -2")
      elseif key == 75 or key == 107 then  -- 'K' or 'k'
        vim.cmd("resize +2")
      elseif key == 74 or key == 106 then  -- 'J' or 'j'
        vim.cmd("resize -2")
      end
      vim.cmd("redraw")
      key = vim.fn.getchar()
    end
  end
end

-- Exchange ; and :
map("n", ";", ":", { silent = true })
map("n", ":", ";", { silent = true })

-- Press kj to exit
map("i", "kj", "<ESC>", { silent = true })

-- Faster line navigation
map("n", "K", "5k", { silent = true })
map("n", "J", "5j", { silent = true })

-- move cursor forward/backward under INSERT mode
map("i", "<C-f>", "<Right>", {noremap = true, silent = true})
map("i", "<C-b>", "<Left>", {noremap = true, silent = true})

-- override the default nvim shortcuts for recursively change window size
vim.keymap.set('n', '<C-w>L', create_resize_command("vertical resize +2"), { desc = 'Increase width recursively'  })
vim.keymap.set('n', '<C-w>H', create_resize_command("vertical resize -2"), { desc = 'Decrease width recursively'  })
vim.keymap.set('n', '<C-w>K', create_resize_command("resize +2"), { desc = 'Increase height recursively'  })
vim.keymap.set('n', '<C-w>J', create_resize_command("resize -2"), { desc = 'Decrease height recursively'  })
