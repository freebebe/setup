You may try entr tool to run arbitrary commands when files change. Example for files:

$ ls -d * | entr sh -c 'make && make test'

or:

$ ls *.css *.html | entr reload-browser Firefox

or print Changed! when file file.txt is saved:

$ echo file.txt | entr echo Changed!

For directories use -d, but you've to use it in the loop, e.g.:

while true; do find path/ | entr -d echo Changed; done

or:

while true; do ls path/* | entr -pd echo Changed; done


