local M = {}

M.commit = [[
Write commit message using the given convention. Ensure the title has a maximum of 50 characters and the message is wrapped at 72 characters. Wrap the whole message in a code block with the language `gitcommit`.

Convention:
- Use the present tense and the imperative mood
- Start the commit message with the emoji :art: when improving the format/structure of the code
- Start the commit message with the emoji :racehorse: when improving performance
- Start the commit message with the emoji :non-potable_water: when plugging memory leaks
- Start the commit message with the emoji :memo: when writing docs
- Start the commit message with the emoji :bug: when fixing a bug
- Start the commit message with the emoji :fire: when removing code or files
- Start the commit message with the emoji :white_check_mark: when adding tests
- Start the commit message with the emoji :lock: when dealing with security
- Start the commit message with the emoji :arrow_up: when upgrading dependencies
- Start the commit message with the emoji :arrow_down: when downgrading dependencies
- Start the commit message with the emoji :shirt: when removing linter warnings
- Start the commit message with the emoji :tongue: when updating translations
- Start the commit message with no emoji in any other case

Make sure to return nothing besides the commit message, as the message will be used in a commit as is.
]]

return M
