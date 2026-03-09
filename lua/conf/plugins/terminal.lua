return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    -- ============================================================
    -- HOME & PROJECT DIRECTORY: Where terminal opens
    -- ============================================================
    -- Get home directory (works on Windows and Linux)
    -- USERPROFILE = Windows home directory
    -- HOME = Unix/Linux home directory
    local home = os.getenv("USERPROFILE") or os.getenv("HOME")
    
    -- ============================================================
    -- TOGGLETERM CONFIGURATION
    -- ============================================================
    require("toggleterm").setup({
      
      -- ============================================================
      -- TERMINAL SIZE: How big the terminal window is
      -- 
      -- Different based on split direction:
      -- - Vertical split: 50% of window width (very readable)
      -- - Horizontal: Default size
      -- - Float: Floating window (separate from editor)
      -- ============================================================
      size = function(term)
        if term.direction == "vertical" then
          return vim.o.columns * 0.5  -- 50% of editor width
        end
      end,

      -- ============================================================
      -- TOGGLE KEYBIND: Open/close terminal
      -- 
      -- <C-\> = Ctrl + Backslash
      -- Press once to open, press again to close (toggle)
      -- 
      -- Why Ctrl+\?
      --    ✅ Easy to reach (next to Backspace)
      --    ✅ Unlikely to conflict with programs
      --    ✅ Fast muscle memory
      -- ============================================================
      open_mapping = [[<c-\>]],

      -- ============================================================
      -- DISPLAY OPTIONS: Visual settings
      -- ============================================================
      hide_numbers = true,               -- Don't show line numbers in terminal
      shade_terminals = true,            -- Slightly darken terminal for distinction
      shading_factor = 2,                -- Darkness level (1=light, 10=dark)

      -- ============================================================
      -- BEHAVIOR: What happens when terminal opens/closes
      -- ============================================================
      start_in_insert = true,            -- Auto-enter insert mode (type immediately)
      insert_mappings = true,            -- Allow Neovim shortcuts in insert mode
      terminal_mappings = true,          -- Allow Neovim shortcuts in terminal mode
      persist_size = true,               -- Remember terminal size between sessions
      close_on_exit = true,              -- Close terminal when command exits

      -- ============================================================
      -- SHELL: Which shell to use
      -- 
      -- "powershell.exe" = Windows PowerShell (current)
      -- "cmd.exe" = Windows Command Prompt (alternative)
      -- "/bin/bash" = Unix/Linux shell (if on Linux)
      -- 
      -- PowerShell is modern and powerful
      -- ============================================================
      shell = "pwsh",

      -- ============================================================
      -- DEFAULT DIRECTORY: Where terminal starts
      -- 
      -- "git_dir" is a built-in ToggleTerm command that finds your 
      -- project root automatically. If no git is found, it uses 
      -- the current directory of your open file.
      -- ============================================================
      dir = "git_dir",

      -- ============================================================
      -- SPLIT DIRECTION: How terminal appears
      -- 
      -- "vertical"     = Side-by-side (50% left, 50% right)
      -- "horizontal"   = Top-bottom
      -- "float"        = Floating window (independent)
      -- "tab"          = New tab
      -- 
      -- "vertical" keeps your code visible while running commands
      -- ============================================================
      direction = "vertical",
    })
  end,
}