#!/usr/bin/ruby

irbrc_path = File.expand_path("~/.irbrc")
begin
  load irbrc_path
rescue Exception
  warn "WARNING: Could not load: #{irbrc_path}" # because of $!.message
end
