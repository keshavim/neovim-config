return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      window = {
        position = "current",
        width = "100%",
        height = "100%",
      },
      filesystem = {
        mappings = {
          ["<CR>"] = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" then
              require("neo-tree.command").execute({ action = "set_root", state = state, node = node })
            else
              require("neo-tree.command").execute({ action = "open", state = state, node = node })
            end
          end,
          ["<bs>"] = function(state)
            local node = state.tree:get_node()
            local parent_node = state.tree:get_node(node:get_parent_id())
            require("neo-tree.command").execute({ action = "set_root", state = state, node = parent_node })
          end,
        },
      },
    })
  end,
}
