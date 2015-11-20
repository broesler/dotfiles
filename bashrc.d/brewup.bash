# Homebrew update all the things
brewup()
{
  brew update           # update homebrew formulas
  brew upgrade --all    # upgrade programs installed via homebrew
  brew prune            # remove old versions of programs
  brew cleanup          # remove old formulas
}
