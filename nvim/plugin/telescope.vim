lua require("guimauve")

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>vrc <cmd>lua require('guimauve.telescope').search_dotfiles()<cr>
nnoremap <leader>gc <cmd>lua require('telescope.builtin').git_branches()<cr>
