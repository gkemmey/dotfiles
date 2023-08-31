if [ -f ~/.zprofile ]; then
  source ~/.zprofile
fi

# -------- java (asdf-java) --------
# ref: https://github.com/halcyon/asdf-java
if [ -n "$BASH_VERSION" ]; then
  # source ~/.asdf/plugins/java/set-java-home.bash
fi
