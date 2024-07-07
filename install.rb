#!/usr/bin/env ruby

DIR = __dir__

module CLI
  def self.main
    brew = system "which brew"
    cmd = ARGV.first

    if brew
      system "brew bundle" unless ARGV.include?('--skip-install')
    end

    system "ansible-playbook ansible/local.yml"
  end
end

CLI.main
