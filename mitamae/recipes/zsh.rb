dotfiles_root = File.expand_path("../../../", __FILE__)

link File.join(ENV["HOME"], ".zshrc") do
  to File.join(dotfiles_root, "zshrc")
  force true
end
