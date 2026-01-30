execute "Clone gnome-terminal-colors-solarized with ghq" do
  command "ghq get https://github.com/Anthony25/gnome-terminal-colors-solarized.git"
  not_if "ghq list | grep -q gnome-terminal-colors-solarized"
end
