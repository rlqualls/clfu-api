module Clfu
  module API

    class Client
  
      def initialize 
        @base_uri = "http://www.commandlinefu.com/commands"
      end
      
      def matching(query, page = 0)
        # chop is necessary because encode64 tacks on a "\n"
        uri = @base_uri + "/matching/" + query + "/" + Base64.encode64(query).chop + "/json/" 
        uri += (page * 25).to_s if page > 0
        response = get_response(uri)
        return build_entries(response)
      end

      def top(page = 0)
        uri = @base_uri + "/browse/sort-by-votes/json/"
        uri += (page * 25).to_s if page > 0
        response = get_response(uri)
        return build_entries(response)
      end

      def last_week
        uri = @base_uri + "/browse/last-week/sort-by-votes/json"
        response = get_response(uri)
        return build_entries(response)
      end

      def build_entries(response)
        entries = []
        json = JSON.parse(response)
        json.each do |item|
          entry = Entry.new(item["id"],
                            item["command"],
                            item["summary"],
                            item["votes"],
                            item["url"])
          entries << entry
        end
        return entries
      end

      def get_response(uri)
        response = open(uri).read
      end

      class Entry < Struct.new(:id, :command, :summary, :votes, :url)
      end

    end
  end
end
