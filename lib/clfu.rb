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
    entries = build_entries(response, :json)
  end

  def self.top
    uri = @@base_uri + "/browse/sort-by-votes/json"
    response = open(uri).read
    clfu_entries = build_entries(response, :json)
  end

  def self.build_entries(response, format=:json)
    entries = []
    case format
    when :json
      json = JSON.parse(response)
      json.each do |item|
      entry = ClfuEntry.new(item["id"],
                            item["command"],
                            item["summary"],
                            item["votes"],
                            item["url"])
      entries << entry
      end
    end
    return entries
  end
end

class ClfuEntry
  attr_reader :id, :command, :summary, :votes, :url

  def initialize(id, command, summary, votes, url)
    @id = id
    @command = command
    @summary = summary
    @votes = votes
    @url = url
  end
end
