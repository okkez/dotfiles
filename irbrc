#!/usr/bin/ruby

# ri を使えるようにする
# 例.
# irb> String.ri
# irb> ri String  # same as above
# irb> String.ri 'reverse'
# irb> ri 'File.new'
def ri(*args)
  puts `ri #{args.join(' ')}`
end

class Module
  def ri(meth=nil)
    if meth
      if instance_methods(false).include? meth.to_s
        puts `ri #{self}##{meth}`
      else
        super
      end
    else
      puts `ri #{self}`
    end
  end
end
# refe2 も使えるように
module Kernel
  def r(*args)
    puts `refe2 #{args.join(' ')}`
  end
  private :r
end

class Module
  def r(meth = nil)
    if meth
      if instance_methods(false).include? meth.to_s
        puts `refe2 #{self}##{meth}`
      else
        super
      end
    else
      puts `refe2 #{self}`
    end
  end
end

IRB.conf[:EVAL_HISTORY] = 1000

# タブ補完を有効にする
require 'irb/completion'

# simple prompt
IRB.conf[:PROMPT_MODE] = :SIMPLE

# ヒストリーを有効にする
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

# サブ irb の設定
IRB.conf[:IRB_RC] = lambda{|_|
  IRB.conf[:IRB_RC] = lambda{|conf| conf.prompt_mode = :DEFAULT }
}
# IPython をまねて edit
require 'tempfile'
def edit
  tfile = Tempfile.new("irb")
  system("vi " + tfile.path)
  if File.readable?(tfile.path)
    load(tfile.path)
  end
end

require 'pp'
require 'yaml'
