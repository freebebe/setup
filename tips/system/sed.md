# 指定
'sed -i "s/NoDisplay=true/NoDisplay=false/g" *.desktop'

> 直接改档案加上 `-i`(inline)

# 插入字串特定pattern之后
`sed '/<pattern>/a'` <string> <file>

# 第一行插入指定信息
`sed 'ia message message message'` filename.md
