return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",  -- Auto-update parsers when plugin updates
  config = function()
    require("nvim-treesitter.configs").setup({
        -- ============================================================
        -- ENSURE INSTALLED: Languages to support
        -- 
        -- Treesitter provides FAST syntax highlighting
        -- (Much faster than regex-based coloring)
        -- 
        -- These are the languages for FLUX development:
        -- ============================================================
        ensure_installed = {
          -- ===== CORE FLUX LANGUAGES =====
          "c",          -- Embedded firmware, FLUX compiler
          "cpp",        -- High-performance code, FLUX components
          "python",     -- ML/quantization scripts, model training
          "rust",       -- FLUX runtime (memory safety critical)

          -- ===== WEB & UI LANGUAGES =====
          "html",       -- Dashboard frontend
          "css",        -- Styling for UI
          "javascript", -- Web tooling, Node.js scripts

          -- ===== CONFIG & UTILITY LANGUAGES =====
          "lua",        -- Neovim configuration files
          "vim",        -- Vim script reference
          "vimdoc",     -- Vim documentation
          "matlab",     -- Engineering/DSP (bonus)
          "query",      -- Treesitter query language (internals)
        },

        -- ============================================================
        -- SYNC INSTALL: Wait for all parsers to download before continuing?
        -- 
        -- false (current) = Install in background, don't block startup
        -- true = Wait until all installed before using editor
        -- 
        -- false is better because:
        --   ✅ Faster startup (editor ready immediately)
        --   ✅ Parsers install while you work
        --   ✅ Auto-install handles missing parsers
        -- ============================================================
        sync_install = false,

        -- ============================================================
        -- AUTO INSTALL: Automatically install missing parsers
        -- 
        -- When you open a file type not yet installed:
        --   ✅ Treesitter auto-installs that parser
        --   ✅ No manual `:TSInstall cpp` needed
        --   ✅ Convenient and automatic
        -- ============================================================
        auto_install = true,

        -- ============================================================
        -- AUTOPAIRS: Auto-close brackets when typing
        -- 
        -- Type ( and it auto-closes: ( | )  (cursor between)
        -- Works for: (), [], {}, "", '', etc.
        -- 
        -- This is handled separately by autopair.lua plugin
        -- But enabled here for consistency
        -- ============================================================
        autopairs = {
          enable = true,
        },

        -- ============================================================
        -- HIGHLIGHT: Syntax coloring based on code structure
        -- 
        -- Treesitter uses AST (Abstract Syntax Tree) for coloring
        -- Much more accurate than regex patterns
        -- 
        -- Example:
        --   Type keyword = Red (always correct)
        --   Variable name = Blue (always correct)
        --   Comment = Gray (always correct)
        -- 
        -- additional_vim_regex_highlighting = false:
        --   Don't fall back to regex (Treesitter is always better)
        -- ============================================================
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,  -- Trust Treesitter completely
        },

        -- ============================================================
        -- INDENT: Auto-indent based on code structure
        -- 
        -- When you press Enter, next line auto-indents
        -- Amount based on nesting level (functions, blocks, etc)
        -- 
        -- Example:
        -- ```c
        -- if (x > 0) {
        --   printf("x is positive");  ← Auto-indented here
        -- }
        -- ```
        -- 
        -- Some languages have indentation issues with Treesitter
        -- (Python is tricky due to significant whitespace)
        -- You can disable for specific languages if needed:
        -- disable = { "python", "c" }
        -- ============================================================
        indent = {
          enable = true,
          -- Uncomment if auto-indent causes issues:
          -- disable = { "python" }
        },

      })
  end
}