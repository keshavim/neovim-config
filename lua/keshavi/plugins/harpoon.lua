local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

--may mofe this to keybindings later

require("which-key").register({
  h = {
    name = "harpoon",
    ["a"] = {mark.add_file, "add file"},
    ["m"] = {ui.toggle_quick_menu,"toggle_quick_menu"},
    ["1"] = { function() ui.nav_file(1) end,"nav_file1"},
    ["2"] = { function() ui.nav_file(2) end,"nav_file2"},
    ["3"] = { function() ui.nav_file(3) end,"nav_file3"},
    ["4"] = { function() ui.nav_file(4) end,"nav_file4"}
  }
}, {prefix = "<leader>"}) 
