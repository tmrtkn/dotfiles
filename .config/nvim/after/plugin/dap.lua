
-- local dap = require('dap')
local dap = require("dap")
local dapui = require("dapui")

dap.adapters.node = {
  type = 'executable',
  command = 'node',
  args = {
    -- os.getenv('HOME') .. '/work/microsoft/vscode-node-debug2/'
    os.getenv('HOME') .. '/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js'
  }
}

dap.configurations.javascript = {
    {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    },
    {
    name = 'Attach to process',
    type = 'node2',
    requets = 'attach',
    processId = require'dap.utils'.pick_process
    }
}

dap.set_log_level('INFO')

dap.defaults.fallback.terminal_win_cmd = '20split new'
-- vim.fn.sign_define('DapBreakpoint',
--                    {text = '🟥', texthl = '', linehl = '', numhl = ''})
-- vim.fn.sign_define('DapBreakpointRejected',
--                    {text = '🟦', texthl = '', linehl = '', numhl = ''})
-- vim.fn.sign_define('DapStopped',
--                    {text = '⭐️', texthl = '', linehl = 'Cursor', numhl = ''})
vim.fn.sign_define('DapBreakpoint',
                   {text = 'B', texthl = '', linehl = '', numhl = ''})
vim.fn.sign_define('DapBreakpointRejected',
                   {text = 'R', texthl = '', linehl = '', numhl = ''})
vim.fn.sign_define('DapStopped',
                   {text = '→', texthl = '', linehl = 'Cursor', numhl = ''})

vim.keymap.set('n', '<leader>dh',
               function() require"dap".toggle_breakpoint() end, { desc = "Debug: Toggle a breakpoint" })
vim.keymap.set('n', '<leader>dH',
               ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { desc = "Debug: Insert conditional breakpoint" })
vim.keymap.set({'n', 't'}, '<A-k>', function() require"dap".step_out() end, { desc = "Debug: Step out" })
vim.keymap.set({'n', 't'}, "<A-l>", function() require"dap".step_into() end, { desc = "Debug: Step into" })
vim.keymap.set({'n', 't'}, '<A-j>', function() require"dap".step_over() end, { desc = "Debug: Step over" })
vim.keymap.set({'n', 't'}, '<A-h>', function() require"dap".continue() end, { desc = "Debug: Continue" })
vim.keymap.set('n', '<leader>dn', function() require"dap".run_to_cursor() end, { desc = "Debug: Run to cursor" })
vim.keymap.set('n', '<leader>dc', function() require"dap".terminate() end, { desc = "Debug: Terminates the debug session" })
vim.keymap.set('n', '<leader>dR',
               function() require"dap".clear_breakpoints() end, { desc = "Debug: Clear breakpoints" })
vim.keymap.set('n', '<leader>de',
               function() require"dap".set_exception_breakpoints({"all"}) end, { desc = "Debug: Set exception breakpoints" })

vim.keymap.set('n', '<leader>da', function() require"debugHelper".attach() end, { desc = "Debug: Attach debugger" })
vim.keymap.set('n', '<leader>dA',
               function() require"debugHelper".attachToRemote() end, { desc = "Debug: Attach to remote" })
vim.keymap
    .set('n', '<leader>di', function() require"dap.ui.widgets".hover() end)
vim.keymap.set('n', '<leader>d?', function()
    local widgets = require "dap.ui.widgets";
    widgets.centered_float(widgets.scopes)
end)
vim.keymap.set('n', '<leader>dk', ':lua require"dap".up()<CR>zz')
vim.keymap.set('n', '<leader>dj', ':lua require"dap".down()<CR>zz')
vim.keymap.set('n', '<leader>dr',
               ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l', { desc = "Debug: Toggle REPL" })
vim.keymap.set('n', '<leader>du', ':lua require"dapui".toggle()<CR>')

-- nvim-telescope/telescope-dap.nvim
-- pcall(require('telescope').load_extension, 'dap')
-- require('telescope').extensions.dap.configurations()
vim.keymap.set('n',  '<leader>df', ':Telescope dap frames<CR>', { desc = "Debug: Show frames" })
-- vim.keymap.set('n', '<leader>dc', ':Telescope dap commands<CR>')
vim.keymap.set('n', '<leader>db', ':Telescope dap list_breakpoints<CR>', { desc = "Debug: List breakpoints" })

require('nvim-dap-virtual-text').setup()

-- require("dap-vscode-js").setup({
--     node_path = 'node',
--     debugger_path = os.getenv('HOME') .. '/work/microsoft/vscode-js-debug',
--     adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }
-- })

-- for _, language in ipairs({ "typescript", "javascript" }) do
--     require("dap").configurations[language] = {
--         {
--             type = "pwa-node",
--             request = "launch",
--             name = "Launch file",
--             -- program = "${file}",
--             program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
--             args = { "--inspect-brk", "--threads", "false", "run", "${file}"},
--             autoAttachChildProcesses = true,
--             smartStep = true,
--             console = 'integratedTerminal',
--
--             cwd = "${workspaceFolder}"
--         },
--         {
--             type = "pwa-node",
--             request = "attach",
--             name = "Attach",
--             processId = require'dap.utils'.pick_process,
--             cwd = "${workspaceFolder}"
--         },
--         {
--             type = "node-terminal",
--             request = "launch",
--             name = "#Launch program (node terminal)",
--             cwd = vim.fn.getcwd(),
--             runtimeArgs = { '--loader' },
--             runtimeExecutable = 'node'
--         }
--     }
-- end

require('nvim-test').setup {
  run = true,                 -- run tests (using for debug)
  commands_create = true,     -- create commands (TestFile, TestLast, ...)
  filename_modifier = ":.",   -- modify filenames before tests run(:h filename-modifiers)
  silent = false,             -- less notifications
  term = "terminal",          -- a terminal to run ("terminal"|"toggleterm")
  termOpts = {
    direction = "vertical",   -- terminal's direction ("horizontal"|"vertical"|"float")
    width = 96,               -- terminal's width (for vertical|float)
    height = 24,              -- terminal's height (for horizontal|float)
    go_back = false,          -- return focus to original window after executing
    stopinsert = "auto",      -- exit from insert mode (true|false|"auto")
    keep_one = true,          -- keep only one terminal for testing
  },
  runners = {               -- setup tests runners
    cs = "nvim-test.runners.dotnet",
    go = "nvim-test.runners.go-test",
    haskell = "nvim-test.runners.hspec",
    javascriptreact = "nvim-test.runners.mocha",
    javascript = "nvim-test.runners.mocha",
    lua = "nvim-test.runners.busted",
    python = "nvim-test.runners.pytest",
    ruby = "nvim-test.runners.rspec",
    rust = "nvim-test.runners.cargo-test",
    typescript = "nvim-test.runners.mocha",
    typescriptreact = "nvim-test.runners.mocha",
  }
}

require('nvim-test.runners.mocha'):setup {
    command = "node_modules/mocha/bin/mocha",                                       -- a command to run the test runner
    args = { "--inspect-brk" },                                       -- default arguments
    -- env = { CUSTOM_VAR = 'value' },                                             -- custom environment variables
    file_pattern = "\\v(__tests__/.*|(spec|test))\\.(js|jsx|coffee|ts|tsx)$",   -- determine whether a file is a testfile
    find_files = { "{name}.test.{ext}", "{name}.spec.{ext}" },                  -- find testfile for a file

    filename_modifier = nil,                                                    -- modify filename before tests run (:h filename-modifiers)
    working_directory = nil,                                                    -- set working directory (cwd by default)
  }

-- dapui.setup()
vim.keymap.set('n', '<leader>do', function() require("dapui").open() end)
vim.keymap.set('n', '<leader>dC', function() require("dapui").close() end)
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open()
-- end
dap.listeners.before.event_terminated["dapui_config"] =
    function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

