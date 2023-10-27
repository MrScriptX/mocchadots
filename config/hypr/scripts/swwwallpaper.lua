local toml = require "toml"

-- replace home directory with tilde alias
local function home_to_alias(path)
    local user_home_pattern = "^/home/[^/]+/"
    local alias_path = string.gsub(path, user_home_pattern, "~")
    return alias_path
end

-- update the current img with new img
local function update_wallpaper(theme, wallpaper)
    -- update cfg file
    toml.parse("~/.config/swww/config.toml")

    -- symlink of image to file use by swwww
    local cmd = "ln -fs " .. wallpaper .. " ~/.config/swww/wall.png"
end

-- display the new img
local function set_wallpaper()
    local cmd = "swww img ~/.config/swww/wall.png"
    cmd = cmd .. "--transition-bezier .43,1.19,1,.4"
    cmd = cmd .. "--transition-type 'grow'"
    cmd = cmd .. "--transition-duration 0.7"
    cmd = cmd .. "--transition-fps 60"
    cmd = cmd .. "--transition-pos '$( hyprctl cursorpos )'"

    os.execute(cmd)
end
