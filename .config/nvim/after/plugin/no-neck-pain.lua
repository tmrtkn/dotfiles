require("no-neck-pain").setup({

  enableOnVimEnter = false,
  width = 80,

  buffers = {
    blend = 0.3,

    scratchPad = {
      enabled = true,
      -- fileName = "no-neck-pain-left.norg"
    }
  },
  integrations = {
    NvimTree = {
      position = "left",
      reopen = true
    },
    undotree = {
      position = "left"
    }
  }
})
