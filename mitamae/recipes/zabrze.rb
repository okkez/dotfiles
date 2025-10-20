dotfiles_root = File.expand_path("../../../", __FILE__)
config_dir = File.join(ENV["HOME"], ".config")

link File.join(config_dir, "zabrze") do
  to File.join(dotfiles_root, "config", "zabrze")
  force true
end
