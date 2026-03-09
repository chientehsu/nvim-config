return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",            -- Beautiful debug UI (variables, stack, etc)
      "nvim-neotest/nvim-nio",           -- Required async library
      "williamboman/mason.nvim",         -- Ensures debuggers are installed
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- ============================================================
      -- DAP UI SETUP: Configure the debug interface
      -- This provides the visual debugging experience
      -- ============================================================
      dapui.setup()

      -- ============================================================
      -- AUTO-OPEN/CLOSE DEBUG UI
      -- 
      -- When you start debugging:
      --   1. UI opens automatically (variables, stack trace, etc.)
      --   2. Shows breakpoints, watch expressions
      --   3. Closes when debugging ends (cleaner workspace)
      -- 
      -- This provides a smooth debugging workflow:
      -- Start (<F5>) → UI appears → Debug → End → UI closes
      -- ============================================================
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()  -- Open when debugging starts
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close() -- Close when target terminates
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close() -- Close when you exit
      end

      -- ============================================================
      -- C / C++ / RUST DEBUGGING: Using codelldb
      -- 
      -- codelldb (from Mason) is your debugger
      -- It works for: C, C++, Rust, and embedded code (AVR/STM32)
      -- 
      -- USAGE WORKFLOW:
      --   1. Compile with debug symbols: gcc -g program.c
      --   2. Set breakpoint: <leader>b (on line you want to pause)
      --   3. Start debugging: <F5> (select executable path)
      --   4. Step through code:
      --      <F10> = Step over (execute line, don't enter functions)
      --      <F11> = Step into (enter functions to debug them)
      --      <F12> = Step out (exit current function)
      --   5. Watch variables: Hover with K to see value
      --   6. Stop: Press <F5> again or let program exit
      -- ============================================================
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          -- Prompt user to select the executable to debug
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',   -- Use project root as working directory
          stopOnEntry = false,          -- Don't pause at main() automatically
                                        -- (pause at breakpoints instead)
        },
      }

      -- ============================================================
      -- REUSE C++ CONFIG FOR C AND RUST
      -- Same debugger (codelldb) works perfectly for all three languages
      -- Just point it to different executables (C, C++, or Rust)
      -- ============================================================
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,
  },
}