#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history' if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.3")

IRB.conf[:SAVE_HISTORY] = 10000000 if IRB.respond_to?(:conf)

# ref: https://twitter.com/hasumikin/status/1722053034958623170
begin
  Gem::Specification.find_by_name("reline", ">= 0.4")

  Reline::Face.config(:completion_dialog) do |conf|
    conf.define :default, foreground: :white, background: :bright_black
    conf.define :enhanced, foreground: :black, background: :bright_cyan
    conf.define :scrollbar, foreground: :bright_cyan, background: :bright_black
  end
rescue Gem::MissingSpecVersionError
end

# loads .railsrc if this looks like a rails session
railsrc_path = File.expand_path('~/.railsrc')

if (ENV['RAILS_ENV'] || defined? Rails) && File.exist?(railsrc_path)
  begin
    load railsrc_path
  rescue Exception
    warn "WARNING: Could not load: #{railsrc_path}" # because of $!.message
  end
end

# loads project specific (i.e. located in project directories) .irbrc files
def load_irbrc(path)
  return if (path == ENV["HOME"]) || (path == '/')

  load_irbrc(File.dirname path)

  irbrc = File.join(path, ".irbrc")

  load irbrc if File.exist?(irbrc)
end
load_irbrc Dir.pwd # starts the .irbrc load process, and should stay at the bottom
