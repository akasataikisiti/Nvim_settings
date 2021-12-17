let g:vdebug_force_ascii = 1

let g:vdebug_options= {
\    "port" : 9000,
\    "server" : '',
\    "timeout" : 20,
\    "on_close" : 'detach',
\    "break_on_open" : 1,
\    "ide_key" : 'vim',
\    "path_maps" : {},
\    "debug_window_level" : 0,
\    "debug_file_level" : 0,
\    "debug_file" : "",
\    "watch_window_style" : 'expanded',
\    "marker_default" : '⬦',
\    "marker_closed_tree" : '▸',
\    "marker_open_tree" : '▾'
\}

let g:vdebug_options['path_maps'] = {"/mnt/d/work/NucleusCMS/": "/mnt/d/work/NucleusCMS/"}

let g:vdebug_keymap = {
\    "run" : "<Leader><F5>",
\    "step_over" : "<Leader><F2>",
\    "step_into" : "<Leader><F3>",
\    "step_out" : "<Leader><F4>",
\    "close" : "<Leader><F6>",
\    "detach" : "<Leader><F7>",
\    "set_breakpoint" : "<Leader><F10>",
\    "get_context" : "<Leader><F11>",
\    "eval_under_cursor" : "<Leader><F12>",
\    "eval_visual" : "<Leader>e",
\}

let g:vdebug_options["break_on_open"] = 0
