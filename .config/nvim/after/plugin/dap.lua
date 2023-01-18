
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

-- dap.configurations.javascript = {
--     name = 'Launch',
--     type = 'node2',
--     request = 'launch',
--     program = '${file}',
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = 'inspector',
--     console = 'integratedTerminal',
-- },
-- {
--     name = 'Attach to process',
--     type = 'node2',
--     requets = 'attach',
--     processId = require'dap.utils'.pick_process
-- }
--
dap.set_log_level('INFO')

dap.defaults.fallback.terminal_win_cmd = '20split new'
vim.fn.sign_define('DapBreakpoint',
                   {text = '🟥', texthl = '', linehl = '', numhl = ''})
vim.fn.sign_define('DapBreakpointRejected',
                   {text = '🟦', texthl = '', linehl = '', numhl = ''})
vim.fn.sign_define('DapStopped',
                   {text = '⭐️', texthl = '', linehl = 'Cursor', numhl = ''})

vim.keymap.set('n', '<leader>dh',
               function() require"dap".toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dH',
               ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set({'n', 't'}, '<A-k>', function() require"dap".step_out() end)
vim.keymap.set({'n', 't'}, "<A-l>", function() require"dap".step_into() end)
vim.keymap.set({'n', 't'}, '<A-j>', function() require"dap".step_over() end)
vim.keymap.set({'n', 't'}, '<A-h>', function() require"dap".continue() end)
vim.keymap.set('n', '<leader>dn', function() require"dap".run_to_cursor() end)
vim.keymap.set('n', '<leader>dc', function() require"dap".terminate() end)
vim.keymap.set('n', '<leader>dR',
               function() require"dap".clear_breakpoints() end)
vim.keymap.set('n', '<leader>de',
               function() require"dap".set_exception_breakpoints({"all"}) end)

vim.keymap.set('n', '<leader>da', function() require"debugHelper".attach() end)
vim.keymap.set('n', '<leader>dA',
               function() require"debugHelper".attachToRemote() end)
vim.keymap
    .set('n', '<leader>di', function() require"dap.ui.widgets".hover() end)
vim.keymap.set('n', '<leader>d?', function()
    local widgets = require "dap.ui.widgets";
    widgets.centered_float(widgets.scopes)
end)
vim.keymap.set('n', '<leader>dk', ':lua require"dap".up()<CR>zz')
vim.keymap.set('n', '<leader>dj', ':lua require"dap".down()<CR>zz')
vim.keymap.set('n', '<leader>dr',
               ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')
vim.keymap.set('n', '<leader>du', ':lua require"dapui".toggle()<CR>')

-- nvim-telescope/telescope-dap.nvim
-- pcall(require('telescope').load_extension, 'dap')
-- require('telescope').extensions.dap.configurations()
vim.keymap.set('n', ':Telescope dap frames<CR>', 't<leader>df')
-- vim.keymap.set('n', '<leader>dc', ':Telescope dap commands<CR>')
vim.keymap.set('n', '<leader>db', ':Telescope dap list_breakpoints<CR>')

require('nvim-dap-virtual-text').setup()

-- require("dap-vscode-js").setup({
--     adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }
-- })

for _, language in ipairs({ "typescript", "javascript" }) do
    require("dap").configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}"
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require'dap.utils'.pick_process,
            cwd = "${workspaceFolder}"
        }
    }
end

-- dapui.setup()
vim.keymap.set('n', '<leader>do', function() require("dapui").open() end)
vim.keymap.set('n', '<leader>dC', function() require("dapui").close() end)
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open()
-- end
dap.listeners.before.event_terminated["dapui_config"] =
    function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

