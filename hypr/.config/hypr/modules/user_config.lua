-- User preferences — edit these values to customize
USER_CONFIG = {
    terminal = "alacritty",
    file_manager = "thunar",
    launcher = "rofi -show drun -modi drun,filebrowser,run,window",
    browser_cmd = "xdg-open https://",
    editor = os.getenv("EDITOR") or "nvim",
}
