return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
  config = function ()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local fmt = require("luasnip.extras.fmt").fmt

    vim.keymap.set({'i', 's'}, '<A-l>', function ()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({'i', 's'}, '<A-h>', function ()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })


    -- class snippet
    ls.add_snippets('cpp', {
      s("class", fmt(
            [[
class {} {{
public:
    {}
}};
            ]],
            {
                i(1, "ClassName"), -- Placeholder for class name
                i(2, "// members"), -- Placeholder for class body
            }
        )
    ),
    })


  end
}
