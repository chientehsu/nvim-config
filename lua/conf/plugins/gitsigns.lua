return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },  -- Load when opening files
  config = function()
    require('gitsigns').setup({
      -- ============================================================
      -- GIT CHANGE SIGNS: Visual indicators in the left margin
      -- 
      -- These symbols show what changed since last commit:
      --   │ = Line was added (green)
      --   │ = Line was modified (yellow/orange)
      --   _ = Line was deleted
      --   ‾ = Deletion at start of file
      --   ~ = Change followed by deletion
      --   ┆ = Untracked file
      -- 
      -- Appears in the "sign column" (left of line numbers)
      -- ============================================================
      signs = {
        add          = { text = '│' },         -- Added line indicator
        change       = { text = '│' },         -- Modified line indicator
        delete       = { text = '_' },         -- Deleted line indicator
        topdelete    = { text = '‾' },         -- Deletion at file start
        changedelete = { text = '~' },         -- Change + deletion combo
        untracked    = { text = '┆' },         -- Untracked file
      },

      -- ============================================================
      -- BLAME: Show who wrote each line and when
      -- 
      -- Appears at end of current line like:
      --   "Your Name 3 days ago"
      -- 
      -- This helps you:
      --   ✅ Find who changed what
      --   ✅ Understand code history
      --   ✅ Know when last modified
      -- 
      -- Hover delay prevents annoying popups while scrolling
      -- ============================================================
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 1000,                -- Wait 1 second before showing blame
        virt_text_pos = 'eol',       -- Show blame at end of line (doesn't cover code)
      },
    })
  end
}