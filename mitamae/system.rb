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

# https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian
directory "/etc/apt/keyrings" do
  action :create
  owner "root"
  group "root"
  mode "0755"
end

http_request "/etc/apt/keyrings/githubcli-archive-keyring.gpg" do
  action :get
  url "https://cli.github.com/packages/githubcli-archive-keyring.gpg"
end

directory "/etc/apt/sources.list.d" do
  action :create
  owner "root"
  group "root"
  mode "0755"
end

file "/etc/apt/sources.list.d/github-cli.list" do
  content "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main"
end

execute "apt update"

package "gh" do
  action :install
end
