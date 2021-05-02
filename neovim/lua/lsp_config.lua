local nvim_lsp = require "lspconfig"
local configs = require "lspconfig/configs"

local map = function(type, key, value)
    vim.fn.nvim_buf_set_keymap(0, type, key, value, {noremap = true, silent = true})
end

local custom_attach = function(client)
    map("n", "]g", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
    map("n", "[g", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")

    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
    map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    map("n", "<leader>gw", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
    map("n", "<leader>gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
    map("n", "<leader>ah", "<cmd>lua vim.lsp.buf.hover()<CR>")
    --map("n", "<M-CR>", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    map("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    map("n", "<leader>ee", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
    map("n", "<leader>ar", "<cmd>lua vim.lsp.buf.rename()<CR>")
    map("n", "<leader>ai", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
    map("n", "<leader>ao", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>")
    print("LSP started.")
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        -- Enable underline, use default values
        underline = true,
        -- Enable virtual text, override spacing to 4
        virtual_text = {
            spacing = 0
        },
        -- Disable a feature
        update_in_insert = false
    }
)

-- Custom Prolog LSP
configs.prolog_lsp = {
    default_config = {
        cmd = {"prolog-lsp.sh"},
        filetypes = {"prolog"},
        root_dir = function(fname)
            return nvim_lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
        end,
        settings = {}
    }
}
-- MS pyright LSP
configs.pyright_lsp = {
    default_config = {
        cmd = {"pyright-langserver", "--stdio"},
        filetypes = {"python"},
        root_dir = nvim_lsp.util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt"),
        settings = {
            analysis = {autoSearchPaths = true},
            pyright = {useLibraryCodeForTypes = true}
        }
    }
}

--require'nvim_lsp'.bashls.setup{on_attach=custom_attach}
--nvim_lsp.pyls.setup {on_attach = custom_attach}
nvim_lsp.prolog_lsp.setup {on_attach = custom_attach}
nvim_lsp.pyright_lsp.setup {on_attach = custom_attach}
nvim_lsp.jdtls.setup {
    on_attach = custom_attach,
    init_options = {
        jvm_args = {
            "-javaagent:/home/kenzie/.local/bin/lombok.jar",
            "-XX:+UseG1GC",
            "-XX:+UseStringDeduplication"
        }
    },
    root_dir = nvim_lsp.util.root_pattern(".git", "pom.xml", "build.xml", "build.gradle")
}
nvim_lsp.gopls.setup {on_attach = custom_attach}
nvim_lsp.tsserver.setup {on_attach = custom_attach}
nvim_lsp.vuels.setup {on_attach = custom_attach}
nvim_lsp.jsonls.setup {on_attach = custom_attach}
nvim_lsp.yamlls.setup {on_attach = custom_attach}
nvim_lsp.clangd.setup {on_attach = custom_attach}

require "nvim-treesitter.configs".setup {
    ensure_installed = "all", -- one of "all", "language", or a list of languages
    update_strategy = "lockfile",
    highlight = {
        enable = true -- false will disable the whole extension
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "go",
            node_decremental = "gi"
        }
    },
    textobjects = {
        swap = {
            enable = true,
            swap_next = {
                ["<leader>l"] = "@parameter.inner"
            },
            swap_previous = {
                ["<leader>h"] = "@parameter.inner"
            }
        },
        select = {
            enable = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["ao"] = "@class.outer",
                ["io"] = "@class.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["ac"] = "@conditional.outer",
                ["ic"] = "@conditional.inner",
                ["ij"] = "@parameter.inner"
            }
        }
    }
}
