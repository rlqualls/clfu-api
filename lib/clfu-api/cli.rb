require 'rubygems'
require 'rb-readline'
require 'highline/import'
require 'open-uri'
require 'base64'
require 'json'
require 'clfu-api/client'

module RbReadline
  def self.prefill_prompt(str)
    @rl_prefill = str
    @rl_startup_hook = :rl_prefill_hook
  end 

  def self.rl_prefill_hook
    rl_insert_text @rl_prefill if @rl_prefill
    @rf_startup_hook = nil
  end
end

def readline_with_hist_management
  line = Readline.readline('CLFU> ', true)
  return nil if line.nil?
  if line =~ /^\s*$/ or Readline::HISTORY.to_a[-2] == line
    Readline::HISTORY.pop
  end
  line
end

module Clfu

  class Cli
  
    def self.run

      # Gracefully exit on CTRL-C (reference: bogojoker.com/readline/)
      stty_save = `stty -g`.chomp
      trap('INT') { puts '\n'; system('stty', stty_save); exit }

      query = "echo"
      query_base64 = Base64.encode64(query).chop #includes \n if no chop

      client = Clfu::API::Client.new
      json = client.matching(query)

      json.reverse_each do |item|
        command_list.push item["command"]
      end

      json.reverse_each do |item|
        Readline::History.push(item["command"]) 
      end

      choice = ""
      choose do |menu|
        menu.prompt = "Choose command line option"
        command_list.each do |item| 
          menu.choice(item) { |c| choice = c }
        end 
      end

      Readline.completion_append_character = " "
      Readline.completion_proc = proc { |s| command_list.grep( /^#{Regexp.escape(s)}/ ) }
      RbReadline.prefill_prompt(choice)

      while line = readline_with_hist_management
        p line
      end

      exec cmd
    end
  end
end
