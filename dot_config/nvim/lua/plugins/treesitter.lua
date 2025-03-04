-- nvim-treesitter plugin is amied for providing code 1) Highliting 2) Intend 3) Folding 4) Locals 5) Injection

return {
  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "cpp",
        "rust",
        "python",
        "markdown",
        "markdown_inline",
        "javascript",
        "sql",
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        disable = { "markdown" },
      },
    },
  },
}
