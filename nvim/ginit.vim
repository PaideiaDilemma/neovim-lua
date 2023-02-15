lua << EOF

-------------
-- Nvim-qt --
-------------

if vim.g.GuiLoaded then
  local font_name = "Fira Code"
  local font_size = 12
  local not_transparent = false

  vim.keymap.set("n", "<F10>", toggleTransparency, { silent = true })

  local function toggleFullscreen()
    if vim.g.GuiWindowFullScreen == 0 then
      vim.cmd("call GuiWindowFullScreen(" .. 1 .. ")")
    else
      vim.cmd("call GuiWindowFullScreen(" .. 0 .. ")")
    end
  end

  vim.keymap.set("n", "<F11>", toggleFullscreen, { silent = true })

  vim.cmd [[
  GuiTabline 0
  GuiPopupmenu 0
  ]]
  vim.cmd("GuiFont! " .. font_name .. ":h" .. font_size)
end

-------------
-- Neovide --
-------------

if vim.g.neovide then
  vim.opt.guifont = "Fira Code:h12"
  vim.g.remember_window_size = true
  vim.g.remember_window_position = true

  local function toggleFullscreen()
    if vim.g.neovide_fullscreen == false then
      vim.cmd "let g:neovide_fullscreen=v:true"
    else
      vim.cmd "let g:neovide_fullscreen=v:false"
    end
  end

  vim.keymap.set("n", "<F11>", toggleFullscreen, { silent = true })
end

EOF
