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
    "kevinhwang91/nvim-ufo",
    lazy = false,
    dependencies = {
      "kevinhwang91/promise-async",
    },
    opts = {
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end,
    },
  },
  {
    "github/copilot.vim",
    event = "VeryLazy",
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      require("which-key").add {
        { "<leader>cd", cmd "Copilot disable", desc = "Disable copilot virtual text" },
        { "<leader>ce", cmd "Copilot enable", desc = "Enable copilot virtual text" },
      }
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    cmd = "Spectre",
    opts = {
      find_engine = {
        ["rg"] = {
          args = {
            "--pcre2",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
        },
      },
      replace_engine = {
        ["sed"] = {
          cmd = "sed",
          args = {
            "-i",
            "-E",
          },
        },
      },
    },
    init = function()
      require("which-key").add {
        { "<A-F>", require("spectre").toggle, desc = "Toggle Spectre" },
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
    "Davidyz/VectorCode",
    lazy = false,
    version = "*", -- optional, depending on whether you're on nightly or release
    build = "pipx upgrade vectorcode", -- optional but recommended if you set `version = "*"`
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("vectorcode").setup {
        async_opts = {
          debounce = 10,
          events = { "BufWritePost", "InsertEnter", "BufReadPost" },
          exclude_this = true,
          n_query = 1,
          notify = false,
          query_cb = require("vectorcode.utils").make_surrounding_lines_cb(-1),
          run_on_register = false,
        },
        async_backend = "default", -- or "lsp"
        exclude_this = true,
        n_query = 1,
        notify = true,
        timeout_ms = 5000,
        on_setup = {
          update = false, -- set to true to enable update when `setup` is called.
        },
      }
    end,
  },
  {
    "ravitemer/mcphub.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup {
        port = 37373,
        config = vim.fn.expand "~/.config/nvim/mcpservers.json",
        shutdown_delay = 0, -- Wait 0ms before shutting down server after last client exits
        log = {
          level = vim.log.levels.WARN,
          to_file = false,
          file_path = nil,
          prefix = "MCPHub",
        },
      }
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "Davidyz/VectorCode",
      "ravitemer/mcphub.nvim",
      "banjo/contextfiles.nvim",
      "ravitemer/codecompanion-history.nvim"
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
              user = "GusChenn"
            },
            slash_commands = {
              ["file"] = {
                opts = {
                  provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
                  contains_code = true,
                },
              },
              codebase = require("vectorcode.integrations").codecompanion.chat.make_slash_command(),
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
              pinned_buffer = "󰏫 ",
              watched_buffer = "watch",
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
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  default = "gemini-2.5-pro",
                  -- default = "claude-3.7-sonnet",
                  -- default = "o3-mini-2025-01-31",
                  -- default = "gpt-4o-2024-08-06",
                },
              },
            })
          end,
        },
        extensions = {
          contextfiles = {
            opts = {
              -- your contextfiles configuration here
              -- or leave it empty to use the default configuration
            },
          },
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
              dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
              ---Enable detailed logging for history extension
              enable_logging = false,
            }
          },
          vectorcode = {
          ---@type VectorCode.CodeCompanion.ExtensionOpts
            opts = {
              tool_group = {
                -- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
                enabled = true,
                -- a list of extra tools that you want to include in `@vectorcode_toolbox`.
                -- if you use @vectorcode_vectorise, it'll be very handy to include
                -- `file_search` here.
                extras = {},
                collapse = false, -- whether the individual tools should be shown in the chat
              },
              tool_opts = {
                ---@type VectorCode.CodeCompanion.LsToolOpts
                ls = {},
                ---@type VectorCode.CodeCompanion.VectoriseToolOpts
                vectorise = {},
                ---@type VectorCode.CodeCompanion.QueryToolOpts
                query = {
                  max_num = { chunk = -1, document = -1 },
                  default_num = { chunk = 50, document = 10 },
                  include_stderr = false,
                  use_lsp = false,
                  no_duplicate = true,
                  chunk_mode = false,
                }
              }
            }
          },
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            description = "Call tools and resources from the MCP Servers",
            opts = {
              requires_approval = true,
              show_result_in_chat = true,  -- Show mcp tool results in chat
              make_vars = true,            -- Convert resources to #variables
              make_slash_commands = true,  -- Add prompts as /slash commands
            },
          },
        }
      }
    end,
    init = function()
      local cmd = require("utils.plugin-helpers").cmd

      -- Could not configure this mapping with which-key
      vim.keymap.set('i', '<C-a>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        silent = true
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
