local config = require("plugins.configs.lspconfig")
local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

local function organize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
    }
    vim.lsp.buf.execute_command(params)
end

lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "rust" },
    root_dir = util.root_pattern("Cargo.toml"),
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                allFeatures = true,
            },
        },
    },
})


lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        preferences = {
            disableSuggestions = true,
        }
    },
    commands = {
        OrganizeImports = {
            organize_imports,
            description = "Organize Imports",
        }
    }
}

lspconfig.tailwindcss.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})