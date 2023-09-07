return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      bind_to_cwd = true,
      cwd_target = {
        sidebar = 'tab',
        current = 'window',
      },
      filtered_items = {
	      visible = true,
	      show_hidden_count = true,
	      hide_dotfiles = false,
	      hide_gitignored = true,
	      hide_by_name = {
	     -- '.git',
	     -- '.DS_Store',
	     -- 'thumbs.db',
	      },
	      never_show = {},
      },
    }
  }
}
