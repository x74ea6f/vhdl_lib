
##[Markdown からいい感じの PDF を作る - Qiita](https://qiita.com/frozenbonito/items/10a38c5fd4ba97a9bef0)

if [[ $# == 0 ]]; then
    echo "Usage $0 doc.md"
    exit
fi

for md_file in "$@"
do
    name=$(basename ${md_file} .md)
    echo "${name}"

    docker run --rm -v $(pwd):/data frozenbonito/pandoc-eisvogel-ja \
    --listings \
    -N \
    --toc \
    -V linkcolor=blue \
    -V table-use-row-colors=true \
    -V titlepage=true \
    -V toc-own-page=true \
    -V toc-title="目次" \
    -o ${name}.pdf \
    ${name}.md

done
