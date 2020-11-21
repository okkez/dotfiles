#!/usr/bin/env ruby

require "fileutils"
require "pathname"

INIT_DIR = Pathname("init").realpath
INIT_LOADER_DIR = Pathname("init-loader").realpath

def create_link(name, priority)
  FileUtils.ln_s((INIT_DIR + name).to_path,
                 (INIT_LOADER_DIR + "#{"%02d" % [priority]}-#{name}").to_path,
                 force: true)
end

INIT_LOADER_DIR.each_entry do |entry|
  next if /.gitignore/ =~ entry.to_path
  path = (INIT_LOADER_DIR + entry)
  if path.file? or path.symlink?
    path.unlink
  end
end

# create_link("ace-isearch.el", 51)
create_link("anzu.el", 51)
# create_link("auto-complete.el", 10)
create_link("base.el", 0)
create_link("c-mode.el", 60)
create_link("color-theme.el", 11)
create_link("company-mode.el", 21)
create_link("css-mode.el", 60)
create_link("cua-mode.el", 10)
create_link("dockerfile-mode.el", 60)
create_link("editorconfig.el", 50)
create_link("edit-server.el", 50)
create_link("flycheck.el", 10)
create_link("flyspell.el", 10)
create_link("go-mode.el", 60)
create_link("haml-mode.el", 60)
create_link("hcl-mode.el", 60)
# create_link("hiki-mode.el", 90)
create_link("ivy-counsel.el", 50)
create_link("html-mode.el", 60)
create_link("js2-mode.el", 60)
# create_link("key-chord.el", 11)
create_link("key.el", 10)
create_link("lookup.el", 10)
create_link("lsp-mode.el", 50)
create_link("magit.el", 50)
create_link("markdown-mode.el", 60)
create_link("migemo.el", 40)
create_link("misc.el", 99)
create_link("org.el", 70)
create_link("path.el", 1)
create_link("popwin.el", 20)
create_link("pos-tip.el", 20)
create_link("rabbit-mode.el", 60)
# create_link("rcodetools.el", 60)
create_link("rd-mode.el", 60)
# create_link("rhtml-mode.el", 60)
create_link("ruby-mode.el", 60)
create_link("rust-mode.el", 60)
create_link("scheme.el", 60)
create_link("scss-mode.el", 60)
create_link("typescript.el", 60)
# create_link("view.el", 60)
create_link("vue-mode.el", 60)
create_link("yasnippet.el", 55)
