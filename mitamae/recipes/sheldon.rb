dotfiles_root = File.expand_path("../../../", __FILE__)
config_dir = File.join(ENV["HOME"], ".config")

link File.join(config_dir, "sheldon") do
  to File.join(dotfiles_root, "config", "sheldon")
  force true
end
