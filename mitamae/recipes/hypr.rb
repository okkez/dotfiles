dotfiles_root = File.expand_path("../../../", __FILE__)
config_dir = File.join(ENV["HOME"], ".config")

%w(hypr waybar mako fuzzel).each do |conf|
  link File.join(config_dir, conf) do
    to File.join(dotfiles_root, "config", conf)
    force true
  end
end
