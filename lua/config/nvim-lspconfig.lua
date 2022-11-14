local lspconfig = require('lspconfig')
lspconfig.ccls.setup {
    single_file_support = true,
    init_options = {
        cache = {
            directory = "~/.cache/ccls";
        },
        highlight = {
            lsRanges = true;
        },
    },
    filetypes = {
        "c", "cpp", "cc"
    }
}

vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', '<C-M>', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', '<space>r', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', '<space>n', vim.lsp.buf.rename, bufopts)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = false,
  }
)

vim.g.python2_host_prog = '/usr/bin/python'

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
             vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lsp' },
    }
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()
