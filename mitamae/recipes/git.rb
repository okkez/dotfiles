dotfiles_root = File.expand_path("../../../", __FILE__)
config_dir = File.join(ENV["HOME"], ".config")

directory File.join(config_dir, "git") do
  action :create
end

link File.join(config_dir, "git", "config") do
  to File.join(dotfiles_root, "config", "git", "config")
  force true
end
