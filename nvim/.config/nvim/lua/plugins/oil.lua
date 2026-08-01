return {
  -- 1. Tambahkan oil.nvim
  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      view_options = {
        show_hidden = true,
      },
    },
    -- Shortcut untuk buka oil (biasanya diganti jadi '-' sesuai rekomendasi authornya)
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    },
  },

  -- 2. Matikan Neo-tree (Explorer bawaan LazyVim)
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
}
