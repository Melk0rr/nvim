local utils = require("heirline.utils")
local cmp = require("user.plugins.heirline.components")

local BufferLine = utils.make_buflist(
    cmp.TablineBufferBlock,
    { provider = "", hl = { fg = "gray" } },
    { provider = "", hl = { fg = "gray" } }
)

return {
  BufferLine
}
