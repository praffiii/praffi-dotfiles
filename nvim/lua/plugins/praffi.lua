local function pad_dashboard_header(header)
  local lines = vim.split(header, "\n", { plain = true, trimempty = false })
  local width = 0

  for _, line in ipairs(lines) do
    width = math.max(width, vim.api.nvim_strwidth(line))
  end

  for index, line in ipairs(lines) do
    lines[index] = line .. string.rep(" ", width - vim.api.nvim_strwidth(line))
  end

  return table.concat(lines, "\n")
end

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
      local state_file = vim.fn.stdpath("state") .. "/praffi-background"
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

      local function apply_transparent_background()
        for _, group in ipairs(transparent_groups) do
          local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
          hl.bg = nil
          hl.ctermbg = nil
          vim.api.nvim_set_hl(0, group, hl)
        end
      end

      local function read_transparent_background()
        local ok, value = pcall(vim.fn.readfile, state_file)
        if not ok or not value[1] then
          return true
        end

        return value[1] ~= "opaque"
      end

      local function write_transparent_background(enabled)
        vim.fn.mkdir(vim.fn.fnamemodify(state_file, ":h"), "p")
        vim.fn.writefile({ enabled and "transparent" or "opaque" }, state_file)
      end

      local function set_transparent_background(enabled, notify, persist)
        vim.g.praffi_transparent_background = enabled

        if enabled then
          require("kanagawa").setup(opts)
        else
          require("kanagawa").setup({ transparent = false })
        end

        vim.cmd.colorscheme("kanagawa-wave")

        if enabled then
          apply_transparent_background()
        end

        if notify then
          vim.notify("Neovim background: " .. (enabled and "transparent" or "opaque"))
        end

        if persist then
          write_transparent_background(enabled)
        end
      end

      set_transparent_background(read_transparent_background(), false, false)
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("praffi_transparent_background", { clear = true }),
        callback = function()
          if vim.g.praffi_transparent_background ~= false then
            apply_transparent_background()
          end
        end,
      })

      vim.keymap.set("n", "<leader>ut", function()
        set_transparent_background(vim.g.praffi_transparent_background == false, true, true)
      end, { desc = "Toggle Transparent Background" })
    end,
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        width = 104,
        formats = {
          header = { "%s", align = "center" },
        },
        preset = {
          header = pad_dashboard_header([=[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⣿⡾⣿⣿⣿⣿⣿⣿⣿⣬⣥⣤⣠⡦⠖⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣿⣿⣿⣿⣿⣿⣿⣿⡟⠛⠆⢀⠀⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣤⣄⣠⣤⣄⠄⡀⢠⣯⣿⣿⣿⣿⣿⣿⣾⣷⣤⢔⣊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⣿⣿⣿⣿⣿⣾⣽⣧⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣭⡟⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⢀⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡗⠀⠻⢿⣿⣉⠛⢻⣿⠉⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠸⠀⠀⣼⢯⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣿⣿⢿⣿⣷⠠⢠⢏⣿⠉⠉⠩⠛⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⠄⠀⠓⣶⣯⣿⣿⣿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⣇⣚⡁⠀⠁⢠⠀⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠈⠃⡀⠀⣿⣿⣿⣿⣿⣟⣿⣯⣷⣻⣽⣿⣯⣟⢻⣻⣿⣿⣿⣷⢶⠞⢗⣲⣄⡤⡂⠉⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⣹⠛⠏⢳⡀⠹⣿⣿⣿⣿⣿⣿⣿⣯⣤⣝⣿⣿⣿⣿⣿⣶⣷⣟⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣦⡿⠋⣗⠤⢹⡜⢛⠻⣿⣿⣷⣾⣿⣯⣧⡽⣿⣿⣿⣿⣷⣍⢳⢥⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡗⠍⣅⣴⣿⣄⡘⠆⠈⠨⡌⢻⣿⡗⣬⣼⢟⣫⡾⢿⣿⣿⣿⣿⡿⡄⢮⣆⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢠⠦⢀⡀⠀⠀⠀⢇⢸⡭⠓⠁⠁⠜⠈⠄⠀⠱⡀⢻⣿⣾⡤⢼⣿⣖⣿⣿⣿⣿⣿⣷⡆⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢀⣔⣋⣥⢋⢹⡀⠀⠀⢰⢸⢀⢴⣀⣤⠦⠀⠨⠃⠀⠒⢮⣿⣵⣧⣸⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⡄⠄⠀⠀⠀⠀⠀⠀⠀
⠀⣀⡆⡎⡀⠀⠀⠀⠀⠀⠀⠰⠀⠸⠀⠷⣶⣆⣶⡆⠀⠀⣀⣿⡿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⣰⠆⢀⡀⠆⠀⠀⠀⠀
⠀⢕⣿⢀⣱⠪⢧⢻⠇⢀⠀⠀⠀⠀⠀⠀⠙⠯⡄⣙⣧⢤⣷⠿⣿⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠛⣴⣵⡿⣣⢨⠄⠀⠀
⢰⡆⡜⡎⠁⠀⢰⠒⣾⢠⡄⠀⠀⠀⠀⠀⠀⠀⠸⢿⣿⠿⠁⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⢦⣗⣈⢻⣄⡟⠅⣀⢠⡄
⠀⢿⠀⠐⢠⣆⠲⡶⡗⠱⡇⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠩⣽⣿⣿⡳⣿⢴⡿⠅
⢰⢘⠀⢻⡄⢧⠸⣗⡧⢄⣾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⢠⣟⣾⡇⢹⠓⠀⠀
⠈⡈⡀⠀⠁⡈⠚⣿⣉⣓⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⠾⠃⣯⠀⡀⠀
⠀⢳⣤⡀⠀⢰⠀⠻⣿⡿⠀⠀⠀⠀⠀⠀⠀⢀⠀⢠⠎⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣳⠆⢱⡇⠘⣄
⠀⠈⠿⠹⠆⢀⡆⠈⠁⡇⠀⠀⠀⠀⠀⠀⡞⠃⣿⡏⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠻⢠⠀⡇⡀⢚
⠀⠀⠀⣼⠀⠸⠅⠀⠀⢺⠀⠀⠀⠀⠀⣼⡷⢋⣼⢷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢾⣧⢰⠃⢠
⠀⠀⢀⠫⠀⣆⠀⠀⠀⢚⠄⠀⠀⠀⠀⠛⣠⠋⢸⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⣻⡆⠘⠄⠈
⠀⠀⢀⡀⠇⠀⠀⡀⠀⣿⡸⣤⣤⣀⠀⢸⣧⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣻⣇⢠⠀⡀
⠀⠀⣸⡇⢠⠀⠀⢠⠃⠘⣽⣿⣿⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡗⢙⣮⠂⠀⠀
⠀⢰⣿⣿⣈⠀⠀⠠⠷⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠲⠄⢃⠀⠀
⠀⠘⣿⣿⣿⡄⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠁⠀⠀⠀⠀
⠀⠀⣿⣿⣿⣧⣰⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢂⠂⡀
          ]=]),
        },
        sections = {
          { section = "header", padding = 1 },
          {
            text = {
              { "[f]", hl = "SnacksDashboardKey" },
              { " Find File   ", hl = "SnacksDashboardDesc" },
              { "[n]", hl = "SnacksDashboardKey" },
              { " New File   ", hl = "SnacksDashboardDesc" },
              { "[p]", hl = "SnacksDashboardKey" },
              { " Projects   ", hl = "SnacksDashboardDesc" },
              { "[g]", hl = "SnacksDashboardKey" },
              { " Find Text   ", hl = "SnacksDashboardDesc" },
              { "[r]", hl = "SnacksDashboardKey" },
              { " Recent Files", hl = "SnacksDashboardDesc" },
            },
            align = "center",
            padding = 0,
          },
          {
            text = {
              { "[c]", hl = "SnacksDashboardKey" },
              { " Config   ", hl = "SnacksDashboardDesc" },
              { "[s]", hl = "SnacksDashboardKey" },
              { " Restore Session   ", hl = "SnacksDashboardDesc" },
              { "[x]", hl = "SnacksDashboardKey" },
              { " Lazy Extras   ", hl = "SnacksDashboardDesc" },
              { "[l]", hl = "SnacksDashboardKey" },
              { " Lazy   ", hl = "SnacksDashboardDesc" },
              { "[q]", hl = "SnacksDashboardKey" },
              { " Quit", hl = "SnacksDashboardDesc" },
            },
            align = "center",
            padding = 1,
          },
          { key = "f", action = ":lua Snacks.dashboard.pick('files')", hidden = true },
          { key = "n", action = ":ene | startinsert", hidden = true },
          { key = "p", action = ":lua Snacks.picker.projects()", hidden = true },
          { key = "g", action = ":lua Snacks.dashboard.pick('live_grep')", hidden = true },
          { key = "r", action = ":lua Snacks.dashboard.pick('oldfiles')", hidden = true },
          { key = "c", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", hidden = true },
          { key = "s", action = ":lua require('persistence').load()", hidden = true },
          { key = "x", action = ":LazyExtras", hidden = true },
          { key = "l", action = ":Lazy", hidden = true },
          { key = "q", action = ":qa", hidden = true },
          { section = "startup" },
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
