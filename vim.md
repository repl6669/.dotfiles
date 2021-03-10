# Vim

## Commands

### Package commands

#### Vinegar (Basic file explorer)

`-`: Open Vinegar
`d`: Create directory
`D`: Delete directory or file under cursor (with confirmation)
`R`: Rename a file under cursor
`%`: Create a new file
`.`: Start a command line with the path of the file
`!`: As above, but use a |:!| command line
`y.`: Yank the current line or [count] lines as absolute paths
`<C-6>`  (`<C-^>`): Close Vinegar and get back to current file

#### Eunuch (Basic file operations)

`:Delete`: Delete a buffer and the file on disk simultaneously.
`:Unlink`: Like `:Delete`, but keeps the now empty buffer.
`:Move`: Rename a buffer and the file on disk simultaneously.
`:Rename`: Like `:Move`, but relative to the current file's containing directory.
`:Chmod`: Change the permissions of the current file.
`:Mkdir`: Create a directory, defaulting to the parent of the current file.
`:Cfind`: Run `find` and load the results into the quickfix list.
`:Clocate`: Run `locate` and load the results into the quickfix list.
`:Lfind`/`:Llocate`: Like above, but use the location list.
`:Wall`: Write every open window.  Handy for kicking off tools like [guard][].
`:SudoWrite`: Write a privileged file with `sudo`.
`:SudoEdit`: Edit a privileged file with `sudo`.
File type detection for `sudo -e` is based on original file name.
New files created with a shebang line are automatically made executable.

#### Fern (File explorer)

`H`: Open a file in horizontal split
`V`: Open a file in vertical split
`R`: Rename a file / files (top)
`M`: Move a file / files
`C`: Copy a file / files
`P`: New path for a file
`N`: New file
`D`: New directory
`I`: Toggle hiffen files
`dd`: Move to trash (real mac trash lol)
`<Leader>`: Mark files / directories

