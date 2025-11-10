return {
  {
    "cbochs/grapple.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    opts = {
      scope = "git_branch",
      style = "relative",
      win_opts = {
        border = "solid",
      },
    },
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add {
        { "<leader>p", cmd "Grapple toggle_tags", desc = "Toggle grapple window" },
        { "<leader>pp", cmd "Grapple tag", desc = "Tag current window" },
        { "<leader>l", cmd "Grapple cycle_tags next", desc = "Grapple cycle to next tag" },
        { "<leader>h", cmd "Grapple cycle_tags prev", desc = "Grapple cycle to previous tag" },
      }
    end,
  },
  {
    "github/copilot.vim",
    event = "VeryLazy",
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      -- Disable copilot on org roam search buffers
      vim.g.copilot_filetypes = {
        ["org-roam-select"] = false,
      }

      require("which-key").add {
        { "<leader>cd", cmd "Copilot disable", desc = "Disable copilot virtual text" },
        { "<leader>ce", cmd "Copilot enable", desc = "Enable copilot virtual text" },
      }
    end,
  },
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add {
        { "<leader>rv", cmd "Eview", desc = "Edit view" },
        { "<leader>rc", cmd "Econtroller", desc = "Edit controller" },
        { "<leader>to", "a<%=  %><ESC>3ha", desc = "Create a rails view tag" },
        { "<leader>te", "a<% end %><ESC>", desc = "Create a end rails view tag" },
      }
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      -- "Davidyz/VectorCode",
      "ravitemer/mcphub.nvim",
      "banjo/contextfiles.nvim",
      "ravitemer/codecompanion-history.nvim",
      "franco-ruggeri/codecompanion-spinner.nvim",
    },
    event = "VeryLazy",
    opts = function()
      return {
        strategies = {
          chat = {
            adapter = "copilot",
            roles = {
              llm = function(adapter)
                return string.format(
                  "  %s%s",
                  adapter.formatted_name,
                  " (" .. (adapter.schema.model.default or "unknown") .. ")"
                )
              end,
              user = "  GusChenn",
            },
            slash_commands = {
              ["file"] = {
                opts = {
                  provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
                  contains_code = true,
                },
              },
            },
          },
          inline = {
            adapter = "copilot",
            keymaps = {
              accept_change = {
                modes = { n = "ga" },
                description = "Accept the suggested change",
              },
              reject_change = {
                modes = { n = "gr" },
                description = "Reject the suggested change",
              },
            },
          },
        },
        prompt_library = {
          ["Suggest Refactoring"] = {
            strategy = "chat",
            description = "Suggest refactoring for provided piece of code.",
            opts = {
              modes = { "v" },
              short_name = "refactor",
              auto_submit = false,
              stop_context_insertion = true,
              user_prompt = false,
            },
            prompts = {
              {
                role = "system",
                content = function(context)
                  return [[Act as a seasoned ]]
                    .. context.filetype
                    .. [[ programmer with over 20 years of commercial experience.
      Your task is to suggest refactoring of a specified piece of code to improve its efficiency,
      readability, and maintainability without altering its functionality. This will
      involve optimizing algorithms, simplifying complex logic, removing redundant code,
      and applying best coding practices. Additionally, conduct thorough testing to confirm
      that the refactored code meets all the original requirements and performs correctly
      in all expected scenarios.]]
                end,
              },
              {
                role = "user",
                content = function(context)
                  local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                  return "I have the following code:\n\n```" .. context.filetype .. "\n" .. text .. "\n```\n\n"
                end,
                opts = {
                  contains_code = true,
                },
              },
            },
          },
          ["Document last messages"] = {
            strategy = "chat",
            description = "Summarize the latest messages between the user and the AI for documentation purposes.",
            opts = {
              is_slash_cmd = true,
              short_name = "doc",
              auto_submit = true,
              stop_context_insertion = true,
              user_prompt = false,
            },
            prompts = {
              {
                role = "system",
                content = function(_context)
                  return [[Act as a seasoned project manager with over 20 years of experience in software development.
                  Your task is to summarize the last few messages exchanged between you and the user. You just need to summarize messages
                  that where not included in any summary yet. Avoid bein redundant or repetitive. Take into consideration the previously generated summaries that you are aware of.
                  You can include code snippets in the summary if they are relevant to the context.]]
                end,
              },
              {
                role = "user",
                content = function(_context)
                  return "Can you summarize the last few messages exchanged between us? I need this for documentation purposes."
                end,
                opts = {
                  contains_code = true,
                },
              },
            },
          },
        },
        display = {
          chat = {
            icons = {
              buffer_pin = "󰐃  ",
              buffer_watch = "󰈈  ",
            },
            window = {
              position = "right",
              border = "single",
              opts = {
                cursorline = true,
              },
              show_header_separator = false,
              separator = "",
            },
          },
          action_palette = {
            provider = "telescope",
          },
        },
        adapters = {
          http = {
            copilot = function()
              return require("codecompanion.adapters").extend("copilot", {
                schema = {
                  model = {
                    default = "claude-sonnet-4.5",
                  },
                },
              })
            end,
          },
        },
        extensions = {
          history = {
            enabled = true,
            opts = {
              -- Keymap to open history from chat buffer (default: gh)
              keymap = "gh",
              -- Keymap to save the current chat manually (when auto_save is disabled)
              save_chat_keymap = "sc",
              -- Save all chats by default (disable to save only manually using 'sc')
              auto_save = true,
              -- Number of days after which chats are automatically deleted (0 to disable)
              expiration_days = 10,
              -- Picker interface (auto resolved to a valid picker)
              picker = "telescope", --- ("telescope", "snacks", "fzf-lua", or "default")
              ---Automatically generate titles for new chats
              auto_generate_title = true,
              title_generation_opts = {
                ---Adapter for generating titles (defaults to current chat adapter)
                adapter = nil, -- "copilot"
                ---Model for generating titles (defaults to current chat model)
                model = nil, -- "gpt-4o"
              },
              ---On exiting and entering neovim, loads the last chat on opening chat
              continue_last_chat = true,
              ---When chat is cleared with `gx` delete the chat from history
              delete_on_clearing_chat = false,
              ---Directory path to save the chats
              dir_to_save = vim.fn.stdpath "data" .. "/codecompanion-history",
              ---Enable detailed logging for history extension
              enable_logging = false,
            },
          },
          spinner = {},
        },
      }
    end,
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      -- Could not configure this mapping with which-key
      vim.keymap.set("i", "<C-a>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        silent = true,
      })
      vim.g.copilot_no_tab_map = true

      require("which-key").add {
        { "<A-T>", cmd "CodeCompanionChat Toggle", mode = { "n", "v" }, desc = "Toggle codecompanion chat" },
        { "<leader>ai", cmd "CodeCompanion", mode = { "n", "v" }, desc = "Inline codecompanion prompt" },
        { "<leader>aa", cmd "CodeCompanionActions", mode = { "n", "v" }, desc = "Open codecompanion actions" },
      }
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
    dependencies = {
      { "Bilal2453/luvit-meta", lazy = true },
    },
  },
}
