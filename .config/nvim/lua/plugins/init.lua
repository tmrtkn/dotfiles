return {
  -- Additional lua configuration, makes nvim stuff amazing
  'folke/neodev.nvim',
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Load the colorscheme here
      vim.cmd([[colorscheme catppuccin]])
    end,
    name = "catppuccin"
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    }
  },
  -- Enable the AST tree if wanted
  -- use('nvim-treesitter/playground')

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'lewis6991/gitsigns.nvim',

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    tag = 'nightly'
  },
  'nvim-lualine/lualine.nvim', -- Fancier statusline
  'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
  'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which dependencies local dependencies to be built. Only load if `make` is available
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },

  'nvim-telescope/telescope-dap.nvim',

  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
      }
    end
  },

  'theprimeagen/harpoon',

  'mbbill/undotree',

  -- Parentheses (and such) handling
  'tpope/vim-surround',
  'luochen1990/rainbow',
  -- Plug for inserting brackets, parentheses, quotes, etc in pairs
  -- 'jiangmiao/auto-pairs',
  { 'windwp/nvim-autopairs',
    config = function() require("nvim-autopairs").setup {} end
  },

  'ggandor/leap.nvim',

  'mfussenegger/nvim-dap',
  'jayp0521/mason-nvim-dap.nvim',
  'rcarriga/nvim-dap-ui',

  -- 'nvim-neotest/neotest',
  -- 'nvim-neotest/neotest-vim-test',
  -- 'vim-test/vim-test',
  -- 'adrigzr/neotest-mocha',
  'klen/nvim-test',


  'theHamsta/nvim-dap-virtual-text',
  -- 'Pocco81/dap-buddy.nvim',
  -- 'Pocco81/DAPInstall.nvim',
  -- 'mxsdev/nvim-dap-vscode-js',
  -- { 'microsoft/vscode-js-debug',
  --   opt = true,
  --   build = "npm install --legacy-peer-depts && npm run compile",
  -- },
  {
    'SmiteshP/nvim-navic',
    dependencies = 'neovim/nvim-lspconfig'
  },

  {
    "jcdickinson/wpm.nvim",
    config = function()
      require("wpm").setup({
      })
    end
  },


  { 'shortcuts/no-neck-pain.nvim', tag = "*" },

  { "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = {
      {
	"nvim-lua/plenary.nvim",
	opt = true
      },
      "nvim-neorg/neorg-telescope",
    }
  },

  -- Smarter word motions
  'chaoren/vim-wordmotion',

  -- Nvim session saving with tmux
  'tpope/vim-obsession',
  'christoomey/vim-tmux-navigator',

  -- Theme
}
