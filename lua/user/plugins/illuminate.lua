return {
  "RRethy/vim-illuminate",
  event = "CursorHold",
  config = function ()
    require("illuminate").configure({ delay = 200 })
  end
}
