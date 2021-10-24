local M = {}

M.autopairs = function()
   local present1, autopairs = pcall(require, "nvim-autopairs")
   local present2, autopairs_completion = pcall(require, "nvim-autopairs.completion.cmp")

   if not (present1 or present2) then
      return
   end

   autopairs.setup()
   autopairs_completion.setup {
      map_complete = true, -- insert () func completion
      map_cr = true,
   }
end

M.autosave = function()
   -- autosave.nvim plugin is disabled by default
   local present, autosave = pcall(require, "autosave")
   if not present then
      return
   end

   autosave.setup {
      enabled = vim.g.auto_save or false, -- takes boolean value from init.lua
      execution_message = "autosaved at : " .. vim.fn.strftime "%H:%M:%S",
      events = { "InsertLeave", "TextChanged" },
      conditions = {
         exists = true,
         filetype_is_not = {},
         modifiable = true,
      },
      clean_command_line_interval = 2500,
      on_off_commands = true,
      write_all_buffers = false,
   }
end

M.better_escape = function()
   local config = require("core.utils").load_config()
   vim.g.better_escape_interval = config.options.plugin.esc_insertmode_timeout or 300
end

M.blankline = function()
   vim.g.indent_blankline_show_trailing_blankline_indent = false
   vim.g.indent_blankline_show_first_indent_level = false

   require("indent_blankline").setup {
      indentLine_enabled = 1,
      char = "▏",
      indent_blankline_filetype_exclude = {
         "help",
         "terminal",
         "dashboard",
         "packer",
         "lspinfo",
         "TelescopePrompt",
         "TelescopeResults",
      },
      indent_blankline_buftype_exclude = { "terminal" },
   }
end

M.colorizer = function()
   local present, colorizer = pcall(require, "colorizer")
   if present then
      colorizer.setup({ "*" }, {
         RGB = true, -- #RGB hex codes
         RRGGBB = true, -- #RRGGBB hex codes
         names = false, -- "Name" codes like Blue
         RRGGBBAA = false, -- #RRGGBBAA hex codes
         rgb_fn = false, -- CSS rgb() and rgba() functions
         hsl_fn = false, -- CSS hsl() and hsla() functions
         css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
         css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn

         -- Available modes: foreground, background
         mode = "background", -- Set the display mode.
      })
      vim.cmd "ColorizerReloadAllBuffers"
   end
end

M.comment = function()
   local present, nvim_comment = pcall(require, "nvim_comment")
   if present then
      nvim_comment.setup()
   end
end

M.luasnip = function()
   local present, luasnip = pcall(require, "luasnip")
   if not present then
      return
   end

   luasnip.config.set_config {
      history = true,
      updateevents = "TextChanged,TextChangedI",
   }
   require("luasnip/loaders/from_vscode").load()
end

M.lspkind = function()
   local present, lspkind = pcall(require, "lspkind")
   if present then
      lspkind.init()
   end
end

M.neoscroll = function()
   pcall(function()
   require('neoscroll').setup({
       -- All these keys will be mapped to their corresponding default scrolling animation
       mappings = {'<M-u>', '<M-d>', '<M-b>', '<M-f>',
 		  '<M-y>', '<M-e>', 'zt', 'zz', 'zb'},
       hide_cursor = true,          -- Hide cursor while scrolling
       stop_eof = true,             -- Stop at <EOF> when scrolling downwards
       use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
       respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
       cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
       easing_function = nil,        -- Default easing function
       pre_hook = nil,              -- Function to run before the scrolling animation starts
       post_hook = nil,              -- Function to run after the scrolling animation ends
   })

   end)
end

M.signature = function()
   local present, lspsignature = pcall(require, "lsp_signature")
   if present then
      lspsignature.setup {
         bind = true,
         doc_lines = 2,
         floating_window = true,
         fix_pos = true,
         hint_enable = true,
         hint_prefix = " ",
         hint_scheme = "String",
         use_lspsaga = false,
         hi_parameter = "Search",
         max_height = 22,
         max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
         handler_opts = {
            border = "single", -- double, single, shadow, none
         },
         zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
         padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
      }
   end
end

return M
