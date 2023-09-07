return {
  {
    "nvim-neotest/neotest-vim-test",
    enabled = true,
  },
  {
    "nvim-neotest/neotest-jest",
    enabled = true,
  },
  {
    "nvim-neotest/neotest-plenary",
    enabled = true,
  },
  {
    "nvim-neotest/neotest",
    requires = {
      {
        "nvim-lua/plenary.nvim",
        lazy = false,
      },
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim"
    },
    enabled = true,
    lazy = false,
    config = function ()
      require("neotest").setup({
        adapters = {
          -- require("neotest-python")({
          --   dap = { justMyCode = false },
          -- }),
          require("neotest-plenary"),
          require("neotest-vim-test")({
            ignore_file_types = { "python", "vim", "lua" },
          }),
          require("neotest-jest"),
        },
      })
    end,
  }
}
