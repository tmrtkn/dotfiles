require('neorg').setup {
  load = {
    ["core.defaults"] = {}, -- Loads default behaviour
    ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
    ["core.norg.completion"] = {
      config = {
        engine = 'nvim-cmp'
      }
    }, -- Adds Completion
    -- ["core.presenter"] = {}, -- Adds the Powerpoint-like presenter functionality
    ["core.norg.dirman"] = { -- Manages Neorg workspaces
      config = {
        workspaces = {
          -- work = "~/notes/work",
          notes = "~/notes",
        },
      },
    },
    ["core.norg.journal"] = {
      config = {
        workspace = "notes",
      }
    },
    ["core.keybinds"] = {
      config = {
        neorg_leader=','
      }
    },
    -- ["core.gtd.ui"] = {}, -- Getting Things Done
    -- ["core.gtd.helpers"] = {},
    -- ["core.gtd.queries"] = {},
    -- ["core.neorgcmd"] = {},
    -- ["core.gtd.base"] = {
    --   config = {
    --     workspace = "notes"
    --   }
    -- },
    ["core.integrations.telescope"] = {
    },
    ["core.export"] = {
      export_dir = "notes"
    }
  },
}

