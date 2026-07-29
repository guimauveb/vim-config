-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

local M = {}

local treesitter = function(_, opts)
  -- Prefer git instead of curl in order to improve connectivity in some environments
  require("nvim-treesitter.install").prefer_git = true
  ---@diagnostic disable-next-line: missing-fields
  require("nvim-treesitter.config").setup({
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      -- Disable Treesitter highlighting for some file types
      disable = {},
    },
  })
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
end

M.setup = function(_, opts)
  treesitter(_, opts)
end

return M
