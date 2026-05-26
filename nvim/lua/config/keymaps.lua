-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })

vim.keymap.set("n", "<leader>D", vim.diagnostic.open_float, { desc = "Show diagnostics" })

vim.keymap.set("n", "<leader>cp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy absolute path" })

vim.keymap.set("n", "<leader>cr", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy relative path" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus left" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus right" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus down" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus up" })

local function git_line_history(start_line, end_line)
  start_line, end_line = math.min(start_line, end_line), math.max(start_line, end_line)
  local range = start_line .. "," .. end_line .. ":" .. vim.fn.expand("%:t")
  local command = { "git", "-C", vim.fn.expand("%:p:h"), "--no-pager", "log", "-L", range }
  local output = vim.fn.systemlist(command)
  local command_text = vim.fn.join(vim.tbl_map(vim.fn.shellescape, command), " ")

  vim.cmd("vnew")
  vim.bo.buftype = "nofile"
  vim.bo.filetype = "diff"
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.list_extend({ command_text, "" }, output))
  vim.bo.modified = false
end

vim.keymap.set("n", "<leader>gl", function()
  git_line_history(vim.fn.line("."), vim.fn.line("."))
end, { desc = "Git line history" })

vim.keymap.set("v", "<leader>gl", function()
  git_line_history(vim.fn.line("v"), vim.fn.line("."))
end, { desc = "Git line history" })
