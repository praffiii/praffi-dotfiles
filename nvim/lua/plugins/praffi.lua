return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-wave",
    },
  },

  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    opts = {
      transparent = true,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme("kanagawa-wave")

      local function apply_transparent_background()
        local transparent_groups = {
          "Normal",
          "NormalNC",
          "NormalFloat",
          "FloatBorder",
          "FloatTitle",
          "SignColumn",
          "EndOfBuffer",
          "LineNr",
          "CursorLineNr",
          "StatusLine",
          "StatusLineNC",
          "TabLine",
          "TabLineFill",
          "WinSeparator",
        }

        for _, group in ipairs(transparent_groups) do
          local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
          hl.bg = nil
          hl.ctermbg = nil
          vim.api.nvim_set_hl(0, group, hl)
        end
      end

      apply_transparent_background()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("praffi_transparent_background", { clear = true }),
        callback = apply_transparent_background,
      })
    end,
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [=[
     ██████╗  ██╗
     ██╔══██╗ ██║
     ██████╔╝ ██║
     ██╔═══╝  ██║
     ██║      ██║
     ╚═╝      ╚═╝
          ]=],
        },
      },
      picker = {
        sources = {
          explorer = {
            layout = {
              layout = {
                position = "right",
              },
            },
          },
        },
      },
    },
  },

  {
    "sphamba/smear-cursor.nvim",
    opts = {
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.5,
    },
  },

  {
    "vyfor/cord.nvim",
    opts = {
      display = {
        theme = "minecraft",
        flavor = "dark",
      },
    },
  },

  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader><leader>", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
      { "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "Resume picker" },
      { "<leader>,", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
      { "gd", function() require("fzf-lua").lsp_definitions() end, desc = "Go to definition" },
      { "grr", function() require("fzf-lua").lsp_references() end, desc = "References" },
      { "gri", function() require("fzf-lua").lsp_implementations() end, desc = "Implementations" },
      { "gra", function() require("fzf-lua").lsp_code_actions() end, desc = "Code actions" },
    },
    opts = {
      ui_select = true,
      keymap = {
        builtin = {
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        },
      },
      winopts = {
        height = 0.95,
        width = 0.90,
        preview = {
          layout = "vertical",
          vertical = "down:30%",
        },
      },
      files = {
        formatter = "path.filename_first",
      },
    },
  },

  {
    "stevearc/oil.nvim",
    opts = {
      columns = { "mtime" },
      view_options = {
        show_hidden = true,
        sort = {
          { "type", "asc" },
          { "mtime", "desc" },
        },
      },
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
  },

  {
    "kdheepak/lazygit.nvim",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Lazygit" },
      {
        "<leader>gb",
        function()
          vim.ui.open(vim.fn.systemlist("git remote get-url origin")[1])
        end,
        desc = "Open git remote",
      },
    },
  },

  {
    "esmuellert/codediff.nvim",
    opts = {},
    keys = {
      { "<leader>ru", "<cmd>CodeDiff<cr>", desc = "Diff unstaged" },
      { "<leader>rm", "<cmd>CodeDiff main<cr>", desc = "Diff main" },
      { "<leader>rh", "<cmd>CodeDiff HEAD~1<cr>", desc = "Diff previous commit" },
    },
  },
}
