return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },  -- Required utilities library
  module = "telescope",

  config = function()
    -- ============================================================
    -- TELESCOPE SETUP: Fuzzy finder for navigation
    -- 
    -- Telescope is your project search engine
    -- Press any keybind below to search, type to filter, Enter to jump
    -- ============================================================
    require('telescope').setup({})

    local builtin = require('telescope.builtin')

    -- ============================================================
    -- GIT FILES: Find files tracked by git
    -- 
    -- Only shows files in git repository
    -- Ignores files in .gitignore (no build artifacts, node_modules, etc)
    -- 
    -- Best for: Finding project files quickly
    -- Speed: FASTEST (doesn't search ignored dirs)
    -- ============================================================
    vim.keymap.set("n", "<leader>fg", builtin.git_files, {
      desc = "Find git-tracked files"
    })

    -- ============================================================
    -- LIVE GREP: Search file CONTENTS (not just filenames)
    -- 
    -- Type a word/phrase and find all files containing it
    -- Results update LIVE as you type
    -- 
    -- Example: Search for "thermal" → finds all mentions in code
    -- 
    -- Best for:
    --   ✅ Finding function names
    --   ✅ Finding variable references
    --   ✅ Finding error messages
    --   ✅ Finding TODO comments
    -- 
    -- Speed: MEDIUM (searches all files)
    -- ============================================================
    vim.keymap.set("n", "<leader>fr", builtin.live_grep, {
      desc = "Live grep (search file contents)"
    })

    -- ============================================================
    -- FIND FILES: Search all files in project
    -- 
    -- Shows EVERY file (including ignored files)
    -- Useful for config files (.gitignore, .env, etc)
    -- 
    -- Similar to git_files but MORE comprehensive
    -- Includes build artifacts, dependencies, etc
    -- 
    -- Best for:
    --   ✅ Finding config files
    --   ✅ Finding ignored files
    --   ✅ Searching entire project
    -- 
    -- Speed: SLOW (searches all files including ignored)
    -- ============================================================
    vim.keymap.set("n", "<leader>ff", builtin.find_files, {
      desc = "Find all files"
    })

    -- ============================================================
    -- FIND BUFFERS: Switch between open files
    -- 
    -- Shows only files currently open in Neovim
    -- FASTER than finding files when you want to switch between open buffers
    -- 
    -- Alternative to:
    --   ✅ <S-h> / <S-l> (prev/next buffer)
    --   ✅ Clicking on tab bar
    -- 
    -- Best for: Jumping between files you're currently editing
    -- Speed: INSTANT (only ~10-20 open files)
    -- ============================================================
    vim.keymap.set("n", "<leader>fb", builtin.buffers, {
      desc = "Find open buffers"
    })

    -- ============================================================
    -- FIND FILES (INCLUDING HIDDEN)
    -- 
    -- Shows .files and .directories normally ignored by editors
    -- Useful when looking for:
    --   ✅ .gitignore
    --   ✅ .env
    --   ✅ .vscode/settings.json
    --   ✅ .github/workflows
    -- 
    -- Similar to find_files but with hidden=true flag
    -- 
    -- Speed: SLOW (includes hidden files and ignored)
    -- ============================================================
    vim.keymap.set("n", "<leader>fh", ":Telescope find_files hidden=true <CR>", {
      desc = "Find files (including hidden)"
    })

  end
}