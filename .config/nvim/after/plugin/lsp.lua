local lspz = require("lsp-zero")

lspz.on_attach(function(client, bufnr)
    lspz.default_keymaps({ buffer = bufnr })

    -- vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = bufnr})
end)

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
    },
    formatting = lspz.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<S-tab>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<tab>'] = cmp.mapping.select_next_item(cmp_select),
        ['<S-enter>'] = cmp.mapping.confirm({ select = true }),
    }),
})

lspz.setup_servers({
    "clangd",
    "hls",
    "gdscript",
	"zls",
	"ols",
    "gopls"
})
