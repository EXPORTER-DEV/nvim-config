-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    -- navigate buffer tabs with `H` and `L`
    -- L = {
    --   function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
    --   desc = "Next buffer",
    -- },
    -- H = {
    --   function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    --   desc = "Previous buffer",
    -- },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>bu"] = { ":u1|u<cr>", desc = "Undo all changes in current buffer" },
    ["<C-d>"] = { "caw<cr>", desc = "Delete current word under cursor and put insert mode"},
    ["<C-s>"] = { ":w!<cr>", desc = "Save File" },
    ["<leader>r"] = { name = "Remove current file" },
    ["<leader>rr"] = { function()
      vim.fn.delete(vim.fn.expand('%'))
    end, desc = "Just remove current file"},
    ["<leader>rf"] = { function()
      vim.fn.delete(vim.fn.expand('%'))
      vim.cmd("bdelete!")
    end, desc = "Remove current file and close buffer"},
    ["fj"] = { ":%!jq .<cr>", desc = "Format JSON to readable"},
    ["<leader>fg"] = { ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", desc = "Enter live grep with args mode" },
    ["<Tab>"] = { ":bnext<cr>", desc = "Go to next buffer tab" },
    ["<S-Tab>"] = { ":bprev<cr>", desc = "Go to prev buffer tab" },
    ["<leader>s"] = { name = "Scratches" },
    ["<leader>so"] = { ":ScratchOpen<cr>", desc = "Open list of scratches" },
    ["<leader>sc"] = { ":Scratch<cr>", desc = "Create new scratch" },
    ["<leader>sn"] = { ":ScratchWithName<cr>", desc = "Create new scratch with name" },
    ["<leader>gm"] = { ":Gvdiffsplit!<cr>", name = "Open 3 way merge tools" },
    ["<leader>gl"] = {":Git blame<cr>", desc = "Toggle git blame for current file", noremap = true},
    ["<leader>gC"] = {":Git log --decorate %<cr>", desc = "Commits of current file", noremap = true },
    ["<leader>gc"] = {":Git log --decorate<cr>", desc = "Commits of the repository", noremap = true },
  },
  t = {
    ["<Esc><Esc>"] = { "<C-\\><C-N><cr>", noremap = true },
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
