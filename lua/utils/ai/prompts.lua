local M = {}

M.commit = [[
#git:staged

Write commit message for the staged changes using the conventional commit format. Make sure to **only include the commit type and short description**. **Do not include** the commit message body nor footer. Make sure the commit message is not longer than 70 characters. Include a fitting emoji at the end of the message.

I am passing my project staged changes as context to you.
]]

return M
