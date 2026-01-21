vim.opt.clipboard = 'unnamedplus'
require('core.options')
require('core.keymaps')

-- 2. Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- 3. Plugin Setup
require('lazy').setup({
    spec = {
        -- 1. Import files as modules
        { import = 'core.autocomplete' },
        { import = 'core.coderunner' },
        { import = 'core.autosave' },
        { import = 'core.debugger' },

        -- 2. List of other plugins
        { "rebelot/kanagawa.nvim", priority = 1000, config = function() vim.cmd.colorscheme "kanagawa" end },
        
        { 
            "theHamsta/nvim-dap-virtual-text", 
            dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
            config = function()
                require("nvim-dap-virtual-text").setup({
                    enabled = true,                        -- Explicitly enable
                    enabled_commands = true,               -- Allow manual refresh
                    highlight_changed_variables = true,    -- Better visibility
                    show_stop_reason = true,
                    virt_text_pos = 'eol',                 -- Use 'eol' for guaranteed visibility
                })
            end
        },

        { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function() require('lualine').setup() end },
        { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x", dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" }, lazy = false },
        { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
        { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    }
})

