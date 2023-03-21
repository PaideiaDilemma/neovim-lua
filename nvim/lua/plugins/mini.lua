-----------------------------------------------------------
-- Mini.nvim configuration file
-----------------------------------------------------------

-- Plugin: mini.nvim
-- url: https://github.com/echasnovski/mini.nvim

local status_ok_splitjoin, splitjoin = pcall(require, 'mini.splitjoin')
if not status_ok_splitjoin then
  return
end

splitjoin.setup {}

local status_ok_surround, surround = pcall(require, 'mini.surround')
if not status_ok_surround then
  return
end

surround.setup {}

local status_ok_basics, basics = pcall(require, 'mini.basics')
if not status_ok_basics then
  return
end

basics.setup {
  options = {
    basic = false,
    win_borders = 'single'
  },
  mappings = {
    basic = true,
    windows = true
  },
  autocommands = {
    basic = false
  }
}
