#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 10000000

# loads .railsrc if this looks like a rails session
railsrc_path = File.expand_path('~/.railsrc')

if(ENV['RAILS_ENV'] || defined? Rails) && File.exist?(railsrc_path)
  begin
    load railsrc_path
  rescue Exception
    warn "WARNING: Could not load: #{railsrc_path}" # because of $!.message
  end
end

# uses AwesomePrint as default, unless it's not in the gemfile
begin
  require "awesome_print"
  AwesomePrint.irb!
rescue LoadError
  warn "WARNING: Could not load: awesome_print"
end

# loads project specific (i.e. located in project directories) .irbrc files
def load_irbrc(path)
  return if (path == ENV["HOME"]) || (path == '/')

  load_irbrc(File.dirname path)

  irbrc = File.join(path, ".irbrc")

  load irbrc if File.exists?(irbrc)
end
load_irbrc Dir.pwd # starts the .irbrc load process, and should stay at the bottom
