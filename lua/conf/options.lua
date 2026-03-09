-- ============================================================
-- NEOVIM OPTIONS: Global editor configuration
-- These settings control how Neovim behaves and displays
-- Everything below applies globally unless overridden per-filetype
-- ============================================================

local options = {
  -- ============================================================
  -- FILE OPERATIONS: How Neovim handles saving
  -- ============================================================
  backup = false,                -- Don't create .bak backup files
  swapfile = false,              -- Don't create .swp swap files
  undofile = true,               -- Keep undo history between sessions (in .undodir)
  writebackup = false,           -- Don't backup before overwriting file

  -- ============================================================
  -- ENCODING & CLIPBOARD: Text handling
  -- ============================================================
  fileencoding = "utf-8",        -- Save files in UTF-8 (supports all characters)
  clipboard = "unnamedplus",     -- Use system clipboard for copy/paste

  -- ============================================================
  -- SEARCH BEHAVIOR: How / and ? work
  -- ============================================================
  hlsearch = true,               -- Highlight all search results on screen
  incsearch = true,              -- Show matches while typing (incremental search)
  ignorecase = true,             -- Case-insensitive search (apple = APPLE)
  smartcase = true,              -- BUT case-sensitive if you type uppercase

  -- ============================================================
  -- INDENTATION & FORMATTING: Whitespace defaults
  -- NOTE: These are defaults. Overridden per-filetype below!
  -- ============================================================
  smartindent = true,            -- Auto-indent after brackets/colons
  expandtab = true,              -- Use spaces instead of tabs (no \t character)
  shiftwidth = 4,                -- 4 spaces per indent (for C/C++/Python)
  tabstop = 4,                   -- 4 spaces per \t character

  -- ============================================================
  -- DISPLAY & NUMBERING: Line numbers and visual indicators
  -- ============================================================
  number = true,                 -- Show line numbers (1, 2, 3, ...)
  relativenumber = false,        -- Don't show relative numbers
  numberwidth = 4,               -- Width of line number column
  signcolumn = "yes",            -- Always show sign column (breakpoints, LSP, git changes)
  cursorline = false,            -- Don't highlight current line (can slow down)
  wrap = false,                  -- Don't wrap long lines (use horizontal scroll)

  -- ============================================================
  -- SCROLLING: Context visibility
  -- ============================================================
  scrolloff = 4,                 -- Keep 4 lines above/below cursor when scrolling
  sidescrolloff = 4,             -- Keep 4 columns left/right of cursor

  -- ============================================================
  -- TERMINAL & GUI: Visual environment
  -- ============================================================
  termguicolors = true,          -- Enable 24-bit RGB color (required for good themes)
  mouse = "a",                   -- Enable mouse in all modes
  guifont = "JetBrainsMono_Nerd_Font:h11",  -- Font for GUI (Neovide, Neovim-Qt)

  -- ============================================================
  -- UI ELEMENTS: Statusline and command area
  -- ============================================================
  cmdheight = 2,                 -- Height of command bar
  showmode = false,              -- Don't show --INSERT-- (statusline shows it)
  showtabline = 2,               -- Always show tab/buffer bar

  -- ============================================================
  -- COMPLETION: How autocomplete works
  -- ============================================================
  completeopt = { "menuone", "noselect" },  -- Show menu even with 1 match
  pumheight = 10,                -- Max 10 items in completion menu
  timeoutlen = 1000,             -- Wait 1 second for key sequences
  updatetime = 300,              -- Trigger updates every 300ms

  -- ============================================================
  -- OTHER IMPORTANT OPTIONS
  -- ============================================================
  ro = false,                    -- File is writable (not read-only)
  conceallevel = 0,              -- Show ALL text (don't hide with concealing)

  -- ============================================================
  -- SPLIT BEHAVIOR: Where new splits appear
  -- ============================================================
  splitbelow = true,             -- New horizontal splits open BELOW
  splitright = true,             -- New vertical splits open RIGHT
}

-- ============================================================
-- APPLY ALL OPTIONS GLOBALLY
-- ============================================================
for k, v in pairs(options) do
    vim.opt[k] = v
end

-- ============================================================
-- FILE-TYPE SPECIFIC SETTINGS: Override for specific languages
-- Different languages have different indentation conventions
-- ============================================================
vim.api.nvim_create_augroup("FileTypeSpecific", { clear = true })

-- ============================================================
-- WEB LANGUAGES: Use 2-space indentation
-- 
-- HTML, CSS, JavaScript use 2 spaces (industry standard)
-- Lua (Neovim config) also uses 2 spaces (Neovim convention)
-- ============================================================
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "css", "javascript", "lua" },
    callback = function()
        vim.opt_local.shiftwidth = 2  -- 2 spaces per indent
        vim.opt_local.tabstop = 2     -- 2 spaces per tab
    end,
    group = "FileTypeSpecific",
})

-- ============================================================
-- FORMATTING OPTIONS: Auto-comment settings
-- 
-- By default: Enter on commented line auto-adds comment char
-- Example: // comment<CR> becomes // comment<CR>//
-- 
-- We disable this to have manual control over comments
-- ============================================================
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- ============================================================
-- SHORT MESSAGES: Clean up command-line output
-- 
-- 'c' flag = Skip ins-completion-menu messages
-- Makes command mode cleaner and less cluttered
-- ============================================================
vim.opt.shortmess:append "c"