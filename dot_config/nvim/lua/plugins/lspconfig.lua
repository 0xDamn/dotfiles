return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    -- Mapping lsp related keys
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- disable a "K" keymap
    keys[#keys + 1] = { "K", false }
    -- add a Hover keymap
    keys[#keys + 1] = { "<leader>H", vim.lsp.buf.hover, desc = "Hover" }

    opts.inlay_hints = {
      enable = true,
      exclude = { "rust" },
    }
    
    -- Add an autocommand to explicitly remove the K mapping after LSP attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        -- Use defer_fn to ensure the mapping exists when we try to remove it
        vim.defer_fn(function()
          -- Get the current mappings for "K" in normal mode
          local ok, mappings = pcall(vim.api.nvim_buf_get_keymap, args.buf, 'n')
          if ok then
            -- Check if "K" mapping exists
            for _, map in ipairs(mappings) do
              if map.lhs == "K" then
                -- If it exists, delete it
                vim.keymap.del("n", "K", { buffer = args.buf  })
                break
              end
            end
          end
        end, 100) -- 100ms delay
      end,
    })
    
  end,
}
