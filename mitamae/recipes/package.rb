execute "Install rustup" do
  command "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"
  not_if "test -x #{ENV["HOME"]}/.cargo/bin/rustup"
end

execute "Update Rust" do
  command "rustup update"
end

# Install cargo-binstall from pre-compiled binary to avoid long build time
tmp_tgz = "/tmp/cargo-binstall.tgz"
binstall_url = "https://github.com/cargo-bins/cargo-binstall/releases/latest/download/cargo-binstall-x86_64-unknown-linux-musl.tgz"
cargo_bin_dir = File.join(ENV["HOME"], ".cargo", "bin")
binstall_path = File.join(cargo_bin_dir, "cargo-binstall")

http_request tmp_tgz do
  url binstall_url
  not_if "test -x #{binstall_path}"
end

execute "Extract, install, and cleanup cargo-binstall" do
  command "tar -xf #{tmp_tgz} -C /tmp && mv /tmp/cargo-binstall #{binstall_path} && rm #{tmp_tgz}"
  not_if "test -x #{binstall_path}"
end

cargo_packages = %w[
  alacritty
  git-delta
  lsd
  mise
  sd
  skim
  sheldon
  starship
  tokei
  xsv
  zellij
]
cargo_packages.each do |pkg|
  execute "Install #{pkg} with cargo-binstall" do
    command "#{binstall_path} -y #{pkg}"
  end
end

execute "mise install ghq"
execute "mise use -g ghq"
