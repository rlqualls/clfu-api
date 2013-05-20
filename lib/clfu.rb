#!/usr/bin/env ruby
# Copyright (c) 2013 Robert Qualls
#
# Clfu is an api wrapper for commandlinefu.com

require 'base64'
require 'open-uri'
require 'json'

class Clfu
  @@base_uri = "http://www.commandlinefu.com/commands"
  
  def self.matching(query)
    uri = @@base_uri + "/matching/" + query + "/" + Base64.encode64(query).chop + "/json" 
    response = open(uri).read
    json = JSON.parse(response)  # !> assigned but unused variable - json
  end
end
