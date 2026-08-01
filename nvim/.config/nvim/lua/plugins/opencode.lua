return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Diperlukan untuk input UI dan terminal
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Anda bisa menambahkan konfigurasi spesifik opencode di sini
    }

    -- Diperlukan agar perubahan file otomatis terbaca
    vim.o.autoread = true

    ---------------------------------------------------------------------------
    -- KEYMAPS (Sudah disesuaikan agar tidak bentrok dengan Tmux)
    ---------------------------------------------------------------------------

    -- ASK: Bertanya tentang kode yang dipilih atau di bawah kursor
    vim.keymap.set({ "n", "x" }, "<leader>aa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "AI Ask (OpenCode)" })

    -- ACTION: Menjalankan aksi (Refactor, Fix, dll)
    vim.keymap.set({ "n", "x" }, "<leader>ax", function()
      require("opencode").select()
    end, { desc = "AI Action Selection" })

    -- TOGGLE: Buka/Tutup jendela chat OpenCode
    vim.keymap.set({ "n", "t" }, "<leader>at", function()
      require("opencode").toggle()
    end, { desc = "AI Toggle Chat" })

    -- OPERATOR: Tekan 'go' diikuti motion (misal: goaf untuk satu fungsi)
    vim.keymap.set({ "n", "x" }, "go", function()
      return require("opencode").operator("@this ")
    end, { expr = true, desc = "Add range to opencode" })

    -- LINE OPERATOR: 'goo' untuk memasukkan baris saat ini
    vim.keymap.set("n", "goo", function()
      return require("opencode").operator("@this ") .. "_"
    end, { expr = true, desc = "Add line to opencode" })

    -- NAVIGASI Chat (Scroll up/down di jendela chat)
    vim.keymap.set("n", "<S-C-u>", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "opencode half page up" })

    vim.keymap.set("n", "<S-C-d>", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "opencode half page down" })

    -- Catatan: Bagian increment (+) dan decrement (-) dihapus karena
    -- sekarang <C-a> dan <C-x> bawaan Neovim sudah tidak tertimpa lagi.
  end,
}
