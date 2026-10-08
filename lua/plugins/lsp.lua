return {
    {
        "williamboman/mason.nvim",
        config = true,
    },

    {
        "williamboman/mason-lspconfig.nvim",
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },

        config = function()
            vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

            require("mason").setup()

            require("mason-lspconfig").setup({
                ensure_installed = {
                    -- Python
                    "basedpyright",

                    -- Lua
                    "lua_ls",

                    -- Go
                    "gopls",

                    -- Rust
                    "rust_analyzer",

                    -- C
                    "clangd",

                    -- JavaScript / TypeScript
                    "vtsls",

                    -- Web
                    "html",
                    "cssls",
                    "emmet_ls",

                    -- JSON / JSONC
                    "jsonls",

                    -- Config files
                    "bashls",
                    "yamlls",
                },
            })

            vim.lsp.config("vtsls", {
                root_dir = function(bufnr, on_dir)
                    local root =
                        vim.fs.root(bufnr, { "package.json", "tsconfig.json", "jsconfig.json", ".git" })
                    on_dir(root or vim.fn.getcwd())
                end,
            })

            vim.lsp.config("emmet_ls", {
                filetypes = {
                    "html",
                    "css",
                    "javascript",
                    "javascriptreact",
                    "typescriptreact",
                },
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {
                                "vim",
                            },
                        },
                    },
                },
            })

            vim.lsp.enable({
                -- Python
                "basedpyright",

                -- Lua
                "lua_ls",

                -- Go
                "gopls",

                -- Rust
                "rust_analyzer",

                -- C
                "clangd",

                -- JavaScript / TypeScript
                "vtsls",

                -- HTML / CSS
                "html",
                "cssls",
                "emmet_ls",

                -- JSON / JSONC
                "jsonls",

                -- Config files
                "bashls",
                "yamlls",
            })
        end,
    },
}
