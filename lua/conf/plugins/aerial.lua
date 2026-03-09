return {
  "stevearc/aerial.nvim",
  dependencies = {
     "nvim-treesitter/nvim-treesitter",  -- Fast code structure parsing
     "nvim-tree/nvim-web-devicons"       -- Icons for code elements
  },
  config = function()
    require("aerial").setup({
      -- ============================================================
      -- BACKENDS: Code structure parsing engines
      -- 
      -- Treesitter (first priority) = FAST + ACCURATE
      --   ✅ Best for: C/C++, Rust, Python, JavaScript
      --   ✅ Instant parsing, no language server needed
      --   ✅ Works offline
      -- 
      -- LSP (fallback) = When Treesitter can't parse
      --   ✅ Backup for unsupported languages
      --   ✅ More accurate for some edge cases
      -- 
      -- Order matters: tries Treesitter first, falls back to LSP
      -- ============================================================
      backends = { "treesitter", "lsp" },

      -- ============================================================
      -- LAYOUT: Window appearance and positioning
      -- ============================================================
      layout = {
        max_width = { 40, 0.2 },     -- Max 40 chars OR 20% of window width
        default_direction = "right",  -- Open on right side (doesn't block code)
        placement = "window",         -- Place in current window (not floating)
      },

      -- ============================================================
      -- DISPLAY: Visual indicators
      -- ============================================================
      show_guides = true,             -- Draw lines showing nesting depth
                                      -- Makes it easier to see function hierarchy

      -- ============================================================
      -- AUTO-OPEN BEHAVIOR: Should outline open automatically?
      -- 
      -- Currently disabled (false) for these reasons:
      --   ✅ Saves screen space (you control when you need it)
      --   ✅ Keeps focus on code editor, not sidebar
      --   ✅ Toggle manually with <leader>a (from keymap.lua)
      --   ✅ Faster startup time
      -- 
      -- Set to true if you want permanent outline always visible
      -- ============================================================
      open_automatic = false,
    })
  end
}