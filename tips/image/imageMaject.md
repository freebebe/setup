# 压缩
`
convert -strip -interlace Plane -gaussian-blur 0.05 -quality 85% source.jpg result.jpg
`

&&

`magick source.jpg -strip -interlace Plane -gaussian-blur 0.05 -quality 85% result.jpg`
