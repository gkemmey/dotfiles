require 'rake'

@replace_all = false

desc "install the dot files into user's home directory"
task :install do
  @replace_all = false

  # -------- dotfiles --------
  Dir['*'].each do |file|
    next if %w[Rakefile README.md LICENSE].include? file
    next if File.directory? file

    Dotfile.link(file)
  end

  # -------- vscode --------
  VsCode.settings.link
  VsCode.keybindings.link

  if VsCode.installed?
    VsCode.missing_extensions.each do |extension|
      Helpers.run %Q{code --install-extension #{extension}}
    end
  end

  Helpers.run %Q{mkdir ~/.tmp}
end

namespace :sync do
  namespace :code do
    desc "syncs installed extensions from vscode"
    task :extensions do
      File.write(File.join(root, "vscode/extensions.manifest"), `code --list-extensions`)
    end
  end
end

# -------- helpers --------

module Helpers
  extend self
  @@replace_all = false

  def dry_run?
    ["true", "1", "yes"].include?(ENV["DRY_RUN"])
  end

  def link_file(our_file, their_file)
    run(%Q{rm "#{their_file}"}) if File.exist?(their_file)

    puts "linking #{their_file}"

    run %Q{ln -s "#{our_file}" "#{their_file}"}
  end

  def root
    File.dirname(__FILE__)
  end

  def run(command)
    dry_run? ? puts(command) : system(command)
  end

  def verify_then(&block)
    if @@replace_all || !File.exist?(system_path)
      yield
      return
    end

    print "overwrite #{system_path}? [ynaq]"

    case $stdin.gets.chomp
      when 'a'
        @@replace_all = true
        yield
      when 'y'
        yield
      when 'q'
        exit
      else
        puts "skipping #{system_path}"
    end
  end
end

class Dotfile
  include Helpers

  def self.link(undotted_file)
    new(undotted_file).link
  end

  attr_accessor :file

  def initialize(undotted_file)
    self.file = undotted_file
  end

  def repo_path
    File.join(root, file)
  end

  def dotfile_path
    File.join(ENV["HOME"], ".#{file}")
  end

  alias system_path dotfile_path

  def link
    verify_then { link_file(repo_path, dotfile_path) }
  end
end

module VsCode
  def self.settings
    ConfigFile.new(:settings)
  end

  def self.keybindings
    ConfigFile.new(:keybindings)
  end

  def self.installed?
    settings.vscode_installed?
  end

  def self.missing_extensions
    should_be_installed = File.read(File.join(Helpers.root, "vscode", "extensions.manifest")).lines.map(&:chomp)
    installed = `code --list-extensions`.lines.map(&:chomp)

    should_be_installed - installed
  end

  class ConfigFile
    include Helpers

    attr_accessor :name

    def initialize(name)
      self.name = name
    end

    def repo_path
      File.join(root, "vscode", "#{name}.json")
    end

    def system_path
      File.join(ENV["HOME"], "Library", "Application Support", "Code", "User", "#{name}.json")
    end

    def vscode_installed?
      File.exist?(File.dirname(system_path))
    end

    def link
      unless vscode_installed?
        puts "skipping #{system_path}: vscode isn't installed"
        return
      end

      verify_then { link_file(repo_path, system_path) }
    end
  end
end
