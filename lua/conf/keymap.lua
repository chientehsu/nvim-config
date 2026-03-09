local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- ============================================================
-- LEADER CONFIGURATION
-- ============================================================
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================
-- 1. WINDOW NAVIGATION (Centered & Smooth)
-- ============================================================
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- ============================================================
-- 2. BUFFER MANAGEMENT
-- ============================================================
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>x", ":bd<CR>", opts)
keymap("n", "<leader>X", ":bd!<CR>", opts) -- Shift + X to force close without saving

-- ============================================================
-- 3. TERMINAL & HARDWARE
-- ============================================================
keymap("n", "<leader>t", ":split | terminal<CR>", { desc = "Open Terminal" })
keymap("n", "<C-\\>", ":ToggleTerm<CR>", { desc = "Toggle Terminal" })

-- ============================================================
-- 4. SEARCH & HIGHLIGHTS
-- ============================================================
keymap("n", "<ESC>", ":noh<CR>", opts)

-- ============================================================
-- 5. VISUAL MODE
-- ============================================================
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv=gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv=gv", opts)

-- ============================================================
-- 6. TERMINAL MODE
-- ============================================================
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
keymap("t", "<Esc>", "<C-\\><C-n>", term_opts)

-- ============================================================
-- 7. DEBUGGER (DAP)
-- ============================================================
vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'Debug: Continue' })
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function()
  require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'Conditional Breakpoint' })
vim.keymap.set('n', '<leader>du', function() require('dapui').toggle() end, { desc = 'Toggle Debug UI' })

-- ============================================================
-- 8. CODE OUTLINE (Aerial)
-- ============================================================
keymap("n", "<leader>a", ":AerialToggle!<CR>", { desc = "Toggle Code Outline" })

-- ============================================================
-- 9. CODE FORMATTING
-- Optimized for YOUR Mason setup (clang-format, ruff)
-- ============================================================
vim.keymap.set('n', '<leader>l', function()
  local file_type = vim.bo.filetype
  
  if file_type == 'c' or file_type == 'cpp' or file_type == 'h' or file_type == 'hpp' then
    -- C/C++ → use clang-format (you have it!)
    vim.lsp.buf.format()
  elseif file_type == 'rust' then
    -- Rust → use rustfmt via LSP
    vim.lsp.buf.format()
  elseif file_type == 'python' then
    -- Python → use ruff (you have it, it's fast!)
    vim.cmd('!ruff format %')
    vim.cmd('edit!')  -- Reload file after formatting
  else
    -- Fallback to LSP formatter
    vim.lsp.buf.format()
  end
end, { desc = "Format Code" })

-- ============================================================
-- 10. HEADER ↔ SOURCE TOGGLE
-- ============================================================
local function toggle_header_source()
  local file = vim.fn.expand("%:p")
  local root = vim.fn.expand("%:r")
  
  if file:match("%.h$") or file:match("%.hpp$") then
    for _, ext in ipairs({".cpp", ".c", ".cc", ".cxx"}) do
      local source = root .. ext
      if vim.fn.filereadable(source) == 1 then
        vim.cmd("edit " .. source)
        return
      end
    end
    print("Source file not found")
  else
    for _, ext in ipairs({".h", ".hpp", ".hxx"}) do
      local header = root .. ext
      if vim.fn.filereadable(header) == 1 then
        vim.cmd("edit " .. header)
        return
      end
    end
    print("Header file not found")
  end
end

vim.keymap.set('n', '<leader>o', toggle_header_source, { desc = "Toggle Header/Source" })

-- ============================================================
-- 11. QUICK PYTHON EXECUTION
-- Run Python with your debugpy setup
-- ============================================================
vim.keymap.set('n', '<leader>py', function()
  local file = vim.fn.expand("%:p")
  vim.cmd("split | terminal python " .. file)
end, { desc = "Run Python Script" })

-- ============================================================
-- 12. ULTIMATE SMART BUILD SYSTEM (Windows/PowerShell Optimized)
-- Auto-detects STM32, AVR, CMake, Make, Rust, C/C++, Python
-- ============================================================
local function smart_build()
    vim.cmd("wa") -- Save all buffers
    
    local file_path = vim.fn.expand('%:p')
    local file_dir = vim.fn.expand('%:p:h')
    local file_name = vim.fn.expand('%:t:r')
    local file_ext = vim.fn.expand("%:e")
    local file_full = vim.fn.expand("%:t")

    -- Search UPWARDS through directories to find project roots
    local cargo_path = vim.fn.findfile("Cargo.toml", ".;")
    local cmake_path = vim.fn.findfile("CMakeLists.txt", ".;")
    local makefile_path = vim.fn.findfile("Makefile", ".;")

    -- 1. DETECT RUST
    if cargo_path ~= "" then
        local root = vim.fn.fnamemodify(cargo_path, ":p:h")
        print("🦀 Building Rust project...")
        require("toggleterm").exec("cd '" .. root .. "' ; cargo build")
        
    -- 2. DETECT CMAKE
    elseif cmake_path ~= "" then
        local root = vim.fn.fnamemodify(cmake_path, ":p:h")
        print("🔨 Building with CMake...")
        require("toggleterm").exec("cd '" .. root .. "' ; if (!(Test-Path build)) { mkdir build } ; cd build ; cmake .. ; make -j8")
        
    -- 3. DETECT STM32 & GENERIC MAKEFILES
    elseif makefile_path ~= "" then
        local root = vim.fn.fnamemodify(makefile_path, ":p:h")
        -- Check if .ioc file exists in that same directory
        local ioc_files = vim.fn.glob(root .. "/*.ioc")
        
        if ioc_files ~= "" then
            vim.ui.input({ prompt = 'STM32 Detected! Enter Revision Name (or press Enter for standard build): ' }, function(rev_name)
                if not rev_name or rev_name == "" then 
                    print("🔨 Running standard STM32 Make...")
                    require("toggleterm").exec("cd '" .. root .. "' ; make -j8")
                    return 
                end
                local out_dir = "Revisions"
                -- FIXED: Variables are mapped correctly and 'make clean' clears the junk
                local cmd = string.format(
                    "cd '%s' ; mkdir -Force %s ; make clean ; make TARGET=%s -j8 ; arm-none-eabi-objdump -S build/%s.elf > %s/%s.s ; cp build/%s.hex %s/ ; cp build/%s.elf %s/ ; make clean",
                    root, out_dir, rev_name, rev_name, out_dir, rev_name, rev_name, out_dir, rev_name, out_dir
                )
                print("🚀 Packaging STM32 Revision: " .. rev_name)
                require("toggleterm").exec(cmd)
            end)
        else
            print("🔨 Building with generic Makefile...")
            require("toggleterm").exec("cd '" .. root .. "' ; make -j8")
        end

    -- 4. SINGLE FILE / HARDWARE FALLBACKS
    else
        if file_ext == "c" then
            -- 🕵️ DETECT AVR BY READING SOURCE FILE
            local is_avr = false
            local lines = vim.fn.readfile(file_path, '', 20)
            for _, line in ipairs(lines) do
                if line:match("avr/") then
                    is_avr = true
                    break
                end
            end

            if is_avr then
                -- AVR stuff stays the same...
            else
                print("⚙️  Compiling standard C file for PC...")
                -- CHANGED ; to && right before the .\\%s
                require("toggleterm").exec(string.format("cd '%s' ; gcc -O2 %s -o %s && .\\%s", file_dir, file_full, file_name, file_name))
            end

        elseif file_ext == "cpp" or file_ext == "cc" then
            print("⚙️  Compiling C++ file...")
            -- CHANGED ; to &&
            require("toggleterm").exec(string.format("cd '%s' ; g++ -O2 %s -o %s && .\\%s", file_dir, file_full, file_name, file_name))
        elseif file_ext == "py" then
            print("🐍 Running Python...")
            require("toggleterm").exec(string.format("cd '%s' ; python %s", file_dir, file_full))
        elseif file_ext == "rs" then
            print("🦀 Running Rust file...")
            -- CHANGED ; to &&
            require("toggleterm").exec(string.format("cd '%s' ; rustc %s && .\\%s", file_dir, file_full, file_name))
        else
            print("❌ No build system or recognized filetype found.")
        end
    end
end
vim.keymap.set('n', '<leader>m', smart_build, { desc = "Smart Build / Flash / Run" })

-- ============================================================
-- 12.1 STM32 DEDICATED REVISION BUILD (<leader>sr)
-- ============================================================
local function stm32_revision_build()
    vim.ui.input({ prompt = 'Enter Revision Name (e.g., Rev09_Final): ' }, function(rev_name)
        if not rev_name or rev_name == "" then return end
        local out_dir = "Revisions"
        -- FIXED: Variables mapped correctly and 'make clean' clears the junk
        local cmd = string.format(
            "mkdir -Force %s ; make clean ; make TARGET=%s -j8 ; arm-none-eabi-objdump -S build/%s.elf > %s/%s.s ; cp build/%s.hex %s/ ; cp build/%s.elf %s/ ; make clean",
            out_dir, rev_name, rev_name, out_dir, rev_name, rev_name, out_dir, rev_name, out_dir
        )
        print("🚀 Packaging Revision: " .. rev_name)
        require("toggleterm").exec(cmd)
    end)
end
vim.keymap.set('n', '<leader>sr', stm32_revision_build, { desc = "Build Custom STM32 Revision" })

-- ============================================================
-- 12.2 DEDICATED AVR FLASH BACKUP (<leader>af)
-- ============================================================
vim.keymap.set('n', '<leader>af', function()
    local file_path = vim.fn.expand('%:p')
    local file_dir = vim.fn.expand('%:p:h')
    local file_name = vim.fn.expand('%:t:r')
    
    print("⚡ Flashing AVR via Atmel-ICE...")
    local full_cmd = string.format(
        "cd '%s' ; avr-gcc -Wall -Os -mmcu=attiny85 -o %s.elf %s ; avr-objcopy -j .text -j .data -O ihex %s.elf %s.hex ; avrdude -c atmelice_isp -p attiny85 -U flash:w:%s.hex:i",
        file_dir, file_name, file_path, file_name, file_name, file_name
    )
    require("toggleterm").exec(full_cmd)
end, { desc = "Build and Flash ATTiny85" })

-- ============================================================
-- 13. COMPILE WITH OPTIMIZATION FLAGS
-- ============================================================
local function compile_for_target(target)
  local file = vim.fn.expand("%")
  local output = vim.fn.expand("%:r")
  local flags = ""
  
  if target == "arm" then
    flags = "-march=armv7-a -O3"
  elseif target == "riscv" then
    flags = "-march=rv64imac -O3"
  elseif target == "x86" then
    flags = "-march=native -O3"
  else
    flags = "-O2"
  end
  
  print("Compiling for " .. target .. "...")
  vim.cmd(string.format("split | terminal gcc %s %s -o %s", flags, file, output))
end

vim.keymap.set('n', '<leader>ca', function() compile_for_target("arm") end, { desc = "Compile for ARM" })
vim.keymap.set('n', '<leader>cr', function() compile_for_target("riscv") end, { desc = "Compile for RISC-V" })

-- ============================================================
-- 14. SERIAL MONITOR
-- Debug AVR/STM32 output
-- ============================================================
vim.keymap.set('n', '<leader>gs', function()
  local port = vim.fn.input("Serial port (default /dev/ttyUSB0): ") or "/dev/ttyUSB0"
  local baud = vim.fn.input("Baud rate (default 115200): ") or "115200"
  vim.cmd("split | terminal screen " .. port .. " " .. baud)
  print("Serial monitor opened. Press Ctrl+A then D to exit.")
end, { desc = "Open Serial Monitor" })

-- ============================================================
-- 15. DOCUMENTATION LOOKUP
-- ============================================================
vim.keymap.set('n', '<leader>q', function()
  local word = vim.fn.expand("<cword>")
  vim.cmd("split | terminal man " .. word)
end, { desc = "Quick Documentation" })

-- ============================================================
-- 16. TOGGLE COMMENTS
-- ============================================================
vim.keymap.set('n', '<leader>cc', 'gcc', {})
vim.keymap.set('v', '<leader>cc', 'gc', {})

-- ============================================================
-- 17. GIT COMMANDS
-- ============================================================
vim.keymap.set('n', '<leader>gp', ':!git push<CR>', { desc = "Git Push" })
vim.keymap.set('n', '<leader>gl', ':!git pull<CR>', { desc = "Git Pull" })
vim.keymap.set('n', '<leader>gst', ':!git status<CR>', { desc = "Git Status" })

-- ============================================================
-- 18. RUN TESTS
-- ============================================================
vim.keymap.set('n', '<leader>rt', function()
  if vim.fn.filereadable("run_tests.sh") == 1 then
    vim.cmd("split | terminal bash run_tests.sh")
  elseif vim.fn.filereadable("pytest.ini") == 1 then
    vim.cmd("split | terminal pytest -v")
  else
    print("No test runner found")
  end
end, { desc = "Run Tests" })

-- ============================================================
-- 19. QEMU EMULATION
-- ============================================================
vim.keymap.set('n', '<leader>qm', function()
  local binary = vim.fn.input("Firmware binary: ")
  vim.cmd("split | terminal qemu-system-arm -M virt -cpu cortex-a72 -m 256 -kernel " .. binary)
end, { desc = "QEMU Emulator" })

-- ============================================================
-- 20. QUICKFIX WINDOW NAVIGATION
-- ============================================================
vim.keymap.set('n', '<leader>cn', ':cnext<CR>', { desc = "Next Error" })
vim.keymap.set('n', '<leader>cp', ':cprev<CR>', { desc = "Previous Error" })
vim.keymap.set('n', '<leader>co', ':copen<CR>', { desc = "Open Error List" })

-- ============================================================
-- 21. RUFF LINTING (Your setup!)
-- Run ruff check on current file
-- ============================================================
vim.keymap.set('n', '<leader>rf', function()
  vim.cmd("!ruff check %")
end, { desc = "Ruff Lint" })

-- ============================================================
-- 22. RUFF FORMATTING
-- Quick format with ruff (faster than black)
-- ============================================================
vim.keymap.set('n', '<leader>rF', function()
  vim.cmd("!ruff format %")
  vim.cmd("edit!")
end, { desc = "Ruff Format" })