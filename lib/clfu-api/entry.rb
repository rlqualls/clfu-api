module Clfu
  module API

    class Entry
      attr_reader :id, :command, :summary, :votes, :url

      def initialize(id, command, summary, votes, url)
        @id = id
        @command = command
        @summary = summary
        @votes = votes
        @url = url
      end
    end
  end
end
