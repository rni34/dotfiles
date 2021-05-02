#!/bin/bash

# function to quickly rebuild python venv
# useful when there is a python version update
rebuild_python() {
  REPO_URL=$(git -C ./src/ remote -v | grep fetch | awk '{print $2}')
  DIR=$(echo "${REPO_URL}" | cut -d '/' -f 2 | cut -d '.' -f 1)
  cd ~/git/
  rm -rf "${DIR}"
  mkdir "${DIR}"
  cd "${DIR}"
  python3 -m venv .
  git clone "${REPO_URL}" src
  source bin/activate
  pip install -r src/req.txt
}

markdown2pdf() {
  SRC="$1"
  DEST="$2"

  pandoc --pdf-engine=xelatex -V geometry:"top=2cm, bottom=1.5cm, left=2cm, right=2cm" "$SRC" -o "$DEST"
}

gogh() {
  bash -c "$(wget -qO- https://git.io/vQgMr)"
}

clone() {
  git clone git@gitlab.com:kenzietandun/"$1"
}

cd() {
  builtin cd "$@"
  if [[ -d "venv" ]]; then
    source venv/bin/activate
  fi
}
