return {
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",

    event = { "BufRead", "BufNewFile" },
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "typescript", "javascript", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        sync_install = false,
        auto_install = true,

        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 10000 * 1024 -- 1 MB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },
}
