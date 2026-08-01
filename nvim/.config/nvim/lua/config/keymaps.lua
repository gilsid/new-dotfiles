-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- -- Fungsi untuk menyimpan nama tema ke file cache
local function save_theme(theme_name)
  local path = vim.fn.stdpath("config") .. "/lua/config/theme_cache.lua"
  local file = io.open(path, "w")
  if file then
    file:write('return "' .. theme_name .. '"')
    file:close()
    vim.notify("Theme saved: " .. theme_name, vim.log.levels.INFO)
  else
    vim.notify("Error: Could not save theme to " .. path, vim.log.levels.ERROR)
  end
end

-- Shortcut <leader>th
vim.keymap.set("n", "<leader>th", function()
  require("telescope.builtin").colorscheme({
    enable_preview = true,
    attach_mappings = function(prompt_bufnr, _)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          save_theme(selection.value)
          vim.cmd("colorscheme " .. selection.value)
        end
      end)
      return true
    end,
  })
end, { desc = "Theme Switcher (Permanent)" })

-- Membuka terminal langsung di split kanan dengan penutupan otomatis
vim.keymap.set("n", "<leader>tr", function()
  vim.cmd("vsplit") -- Buat split vertikal
  vim.cmd("wincmd l") -- Pindah ke kanan
  vim.cmd("term") -- Buka terminal

  -- Matikan nomor baris agar bersih
  vim.wo.number = false
  vim.wo.relativenumber = false

  -- OTOMATIS TUTUP WINDOW SAAT TERMINAL EXIT
  -- Begitu proses shell selesai, window akan ikut tertutup (bclose)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = bufnr,
    callback = function()
      vim.cmd("bdelete!") -- Hapus buffer terminal dan tutup jendelanya
    end,
  })

  vim.cmd("startinsert") -- Langsung mode mengetik
end, { desc = "Terminal di sebelah kanan (Auto-close)" })
