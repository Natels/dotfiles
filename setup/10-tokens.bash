set -e

PRIVATE_PATH="$HOME/.zshenv.private"

function update-token() {
  NAME="$1"
  VALUE="$2"

  PREFIX="^export $NAME"
  REPLACEMENT="export $NAME="'"'"$VALUE"'"'

  grep -q "$PREFIX" "$PRIVATE_PATH" && sed -i "" "s/$PREFIX.*/$REPLACEMENT/" "$PRIVATE_PATH" || echo "$REPLACEMENT" >>"$PRIVATE_PATH"
  sort -o "$PRIVATE_PATH" "$PRIVATE_PATH"
}
