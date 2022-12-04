-----------------------------------------------------------
-- Glance configuration file
----------------------------------------------------------

-- Plugin: glance
-- url: https://github.com/DNLHC/glance.nvim

local status_ok, glance = pcall(require, 'glance')
if not status_ok then
  return
end

glance.setup {
  height = 24,
  preview_win_opts = {
    wrap = false
  },
  winbar = {
    enable = true
  }
}
