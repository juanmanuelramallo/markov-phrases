module Phrases
  module Twitter
    class Tweets
      attr_reader :client, :count, :max_id, :since_id, :user

      def initialize(max_id: nil, user:, since_id: nil, count: 100)
        @client = Phrases::Twitter::Client.new
        @count = count
        @max_id = max_id
        @since_id = since_id
        @user = user

        if @count > 200
          raise Phrases::Errors::TwitterUsageError, 'must ask for 200 tweets max per request'
        end
      end

      def tweets
        client.user_timeline(user, options)
      end

      private

      def options
        opts = {
          count: count,
          exclue_replies: true,
          include_rts: false,
          trim_user: true
        }

        opts.merge!(since_id: since_id) if since_id
        opts.merge!(max_id: max_id) if max_id
        opts
      end
    end
  end
end
