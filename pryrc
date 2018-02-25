#!/usr/bin/ruby

# i don't use pryrc, unless a project already is, so just copy .irbrc file
irbrc_parth = File.expand_path('~/.irbrc')
begin
  load irbrc_parth
rescue Exception
  warn "WARNING: Could not load: #{irbrc_parth}" # because of $!.message
end
