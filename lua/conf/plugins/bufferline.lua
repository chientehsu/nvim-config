return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",  -- Icons for buffer types
  config = function()
    require("bufferline").setup({
      options = {
        -- ============================================================
        -- DISPLAY MODE: Show buffers as tabs
        -- 
        -- "buffers" = Shows all open files at top (current mode)
        -- "tabs" = Alternative tab group mode
        -- 
        -- Buffer mode is better because:
        --   ✅ See all open files instantly
        --   ✅ Switch with: Shift+h/l, <leader>fb, or click
        --   ✅ Close any file with <leader>x
        -- ============================================================
        mode = "buffers",

        -- ============================================================
        -- ALWAYS SHOW BUFFERLINE
        -- 
        -- Shows tab bar even with only one file open
        -- Benefits:
        --   ✅ Consistent UI (always in same place)
        --   ✅ Ready for new files (no surprise layout change)
        --   ✅ Professional appearance
        -- ============================================================
        always_show_bufferline = true,

        -- ============================================================
        -- SEPARATOR STYLE: How tabs are visually separated
        -- 
        -- Options:
        -- "slant"   = Cool angled look (VS Code style) ← CURRENT
        -- "slope"   = Smooth curves
        -- "thick"   = Bold separators
        -- "thin"    = Minimal separators
        -- 
        -- "slant" looks professional and modern
        -- ============================================================
        separator_style = "slant",

        -- ============================================================
        -- CLOSE ICONS ON EACH BUFFER
        -- 
        -- Shows X button on each tab to close that buffer
        -- Lets you close files without typing <leader>x
        -- ============================================================
        show_buffer_close_icons = true,

        -- ============================================================
        -- RIGHTMOST CLOSE ICON
        -- 
        -- Don't show X button at far right edge
        -- Reason: Each tab already has X button, don't need another
        -- ============================================================
        show_close_icon = false,

        -- ============================================================
        -- FILE TREE INTEGRATION
        -- 
        -- Makes bufferline aware of NvimTree sidebar
        -- 
        -- Without this:
        -- File tree covers buffer tabs (bad UX)
        -- With this:
        --   Buffer tabs start where tree ends (good UX)
        -- 
        -- "FLUX CORE" = Label displayed in tree space
        -- ============================================================
        offsets = {
          {
            filetype = "NvimTree",
            text = "PROJECTS",      -- Label shown instead of tree
            text_align = "left",
            separator = true,        -- Visual separator line
          },
        },
      },
    })
  end,
}