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
    # chop is necessary because encode64 tacks on a "\n"
    uri = @@base_uri + "/matching/" + query + "/" + Base64.encode64(query).chop + "/json" 
    response = get_response(uri)
    entries = build_entries(response)
  end

  def self.top(page = 0)
    uri = @@base_uri + "/browse/sort-by-votes/json/"
    uri += (page * 25).to_s if page > 0
    response = get_response(uri)
    clfu_entries = build_entries(response)
  end

  def self.last_week
    uri = @@base_uri + "/browse/last-week/sort-by-votes/json"
    response = get_response(uri)
    entries = build_entries(response)
  end

  def self.build_entries(response)
    entries = []
    json = JSON.parse(response)
    json.each do |item|
      entry = ClfuEntry.new(item["id"],
                            item["command"],
                            item["summary"],
                            item["votes"],
                            item["url"])
      entries << entry
    end
    return entries
  end

  def self.get_response(uri)
    response = open(uri).read
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
