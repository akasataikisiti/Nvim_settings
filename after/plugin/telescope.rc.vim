if !exists('g:loaded_telescope') | finish | endif

nnoremap <silent> <Leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <silent> <Leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <silent> <Leader>fb <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap <silent> <Leader><Space> <cmd>Telescope buffers<cr>
nnoremap <expr> <Leader>fu ':Telescope live_grep<cr>' .  expand('<cword>')
nnoremap <expr> <Leader>fp ':Telescope project<cr>'
xnoremap <leader>fv "zy:<C-u> Telescope live_grep<cr> <C-r>z
nnoremap <leader>fz :<C-u> Telescope live_grep<cr> <C-r>z
" vimのhelptagsを検索できるけどいったんはずす
" nnoremap <silent>  ht <cmd>Telescope help_tags<cr>

lua << EOF
function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
      },
  },
}

--telescope拡張機能追加
telescope.load_extension('project')
telescope.load_extension('fzy_native')
EOF
