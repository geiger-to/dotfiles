#!/usr/bin/env ruby

DIR = __dir__

module CLI
  def self.main
    cmd = ARGV.first
    case cmd
    when "brew"
      system "brew bundle" unless ARGV.include?('--skip-install')
    when "apt"
      # todo
    else
      puts "error: you must specify a target (brew|apt)..."
      puts
      puts "e.g. ./install.rb brew"
      puts
      exit 1
    end

    system "ansible-playbook ansible/local.yml"
  end
end

CLI.main
