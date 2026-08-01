-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Pastikan file ini ada
-- File: ~/.config/nvim/lua/config/options.lua

vim.opt.shiftwidth = 4 -- Ukuran indentasi (saat tekan >> atau <<)
vim.opt.tabstop = 4 -- Lebar satu karakter Tab terlihat seperti 4 spasi
vim.opt.softtabstop = 4 -- Jumlah spasi yang dimasukkan saat tekan Tab di mode Insert
vim.opt.expandtab = true -- Mengubah Tab menjadi Spasi (Sangat Direkomendasikan)

local status, theme = pcall(require, "config.theme_cache")
local default_theme = "tokyonight"

-- Set variable global untuk LazyVim
if status and type(theme) == "string" then
  vim.g.lazyvim_colorscheme = theme
else
  vim.g.lazyvim_colorscheme = default_theme
end

-- Fungsi aman untuk mengganti tema
local function try_colorscheme(name)
  local ok = pcall(vim.cmd, "colorscheme " .. name)
  if not ok and name ~= default_theme then
    pcall(vim.cmd, "colorscheme " .. default_theme)
  end
end

-- Gunakan Autocmd yang lebih aman
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if status and theme then
      -- Beri jeda sangat singkat agar plugin benar-benar siap
      vim.schedule(function()
        try_colorscheme(theme)
      end)
    end
  end,
})
