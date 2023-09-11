return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  colorscheme = "gruvbox",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          "go",
          "json",
          "lua",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    require("dap").adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        -- Should change below path to your absolute path to vscode-js-debug repo:
        args = {"/Users/vadimvaulin/.config/nvim/vscode-js-debug/dist/src/dapDebugServer.js", "${port}"},
      }
    }

    local javascriptConfigurations = {
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to 9229",
        port = 9229,
        restart = true,
        attachExistingChildren = true,
        autoAttachChildProcesses = true,
        continueOnAttach = true,
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to 9230",
        port = 9230,
        restart = true,
        attachExistingChildren = true,
        autoAttachChildProcesses = true,
        continueOnAttach = true,
      },
    }

    require("dap").configurations.javascript = javascriptConfigurations;
    require("dap").configurations.typescript = javascriptConfigurations;

    -- Need following hack to prevent vim heap usage to not increase extreemly high when enter JSON oneline buffer >= 1MB
    vim.cmd([[
      function! g:FckThatMatchParen ()
        if exists(":NoMatchParen")
          :NoMatchParen
        endif
      endfunction
      autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | call FckThatMatchParen() | set noshowmatch | endif
      set synmaxcol=128
      set autoread
    ]])

    require('gitsigns').setup {
      current_line_blame = true,
      on_attach = function(bufnr)
        -- local function map(mode, lhs, rhs, opts)
        --     opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
        --     vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        -- end
      end
    }

    local Terminal = require('toggleterm.terminal').Terminal
    local NodeInspectTerminal = Terminal:new({display_name="Node debug injected", size=80, direction='horizontal', env={NODE_OPTIONS='--inspect-brk'}})

    function ToggleNodeInspectTerminal()
      NodeInspectTerminal:toggle()
    end

    vim.api.nvim_set_keymap("n", "<leader>td", "<cmd>lua ToggleNodeInspectTerminal()<cr>", { desc = "ToggleTerm with Node debug injected" })

    require("nvim-dap-virtual-text").setup({})
  end,
}
