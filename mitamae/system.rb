packages = %w[
  git
  curl
  wget
  jq
  apel
  rdtool-elisp
  emacs
  elpa-magit
  elpa-flycheck
  develock-el
  cmigemo
  rsync
  ruby
  screen
  zsh
  build-essential
  ddskk
  unzip
  aspell
  hunspell
  direnv
]

packages.each do |pkg|
  package pkg do
    action :install
  end
end
