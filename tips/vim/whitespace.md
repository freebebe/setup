The "simplest" way is to just use :substitute:

`:%s/\s\+$//e`

    `:%s` to run :substitute over the range %, which is the entire buffer.
    `\s` to match all whitespace characters.
    `\+` to match 1 or more of them.
    `$` to anchor at the end of the line.
    The `e` flag to not give an error if there is no match (i.e. the file is already without trailing whitespace).

