dotfiles_root = File.expand_path("../../../", __FILE__)
emacs_d_dir = File.join(ENV["HOME"], ".emacs.d")

link File.join(emacs_d_dir, "early-init.el") do
  to File.join(dotfiles_root, "emacs.d", "early-init.el")
  force true
end

link File.join(emacs_d_dir, "init.el") do
  to File.join(dotfiles_root, "emacs.d", "init.el")
  force true
end
