return {
  {
    'saghen/blink.cmp',
    version = '*',
    event = "VeryLazy",
    dependencies = {
      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip',
    },

    opts = {
      -- ============================================================
      -- KEYMAP: Super-Tab
      -- ============================================================
      keymap = { 
        preset = 'super-tab',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
      },

      -- ============================================================
      -- APPEARANCE
      -- ============================================================
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
      },

      -- ============================================================
      -- SOURCES: Simple and working
      -- Removed lazydev (was causing errors and isn't essential for FLUX work)
      -- ============================================================
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- ============================================================
      -- SIGNATURE HELP: Shows function arguments
      -- ============================================================
      signature = { 
        enabled = true,
        window = {
          border = 'rounded',
        }
      },

      -- ============================================================
      -- COMPLETION: Documentation + filtering
      -- ============================================================
      completion = {
        documentation = { 
          auto_show = true, 
          auto_show_delay_ms = 150,
          window = {
            border = 'rounded',
            max_height = 20,
            max_width = 100,
          }
        },
        
        menu = {
          draw = {
            columns = { 
              { "kind_icon" },
              { "label", "label_description", gap = 1 } 
            },
          },
        },

        -- Smart triggers for C/C++/Rust embedded work
        trigger = {
          show_on_blocked_trigger_characters = { '.', '->' },
        },
      },

      -- ============================================================
      -- SNIPPETS: LuaSnip for your custom patterns
      -- ============================================================
      snippets = {
        preset = 'luasnip',
      },

    },
  },
}