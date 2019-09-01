module Phrases
  module Tasks
    class Training
      attr_reader :count, :file_name, :log, :user

      def initialize(user:, count:)
        @count = count
        @file_name = "data/users/#{user}.yml"
        @user = user
        @log = File.exists?(file_name) ? YAML.load_file(file_name) : { 'tweet_ids' => [] }
      end

      def train
        opts = {
          count: count,
          user: user
        }
        opts.merge!(max_id: max_id - 1) if max_id

        tweets = Phrases::Twitter::Tweets.new(opts).tweets
        tweets.each do |tweet|
          next if log['tweet_ids'].include?(tweet.id)

          log['tweet_ids'] << tweet.id
          Phrases::Markov::Builder.new("data/#{user}.yml")
                                  .learn_from_text(tweet.full_text)
        end

        save_log
      end

      private

      def max_id
        log['tweet_ids'].last
      end

      def since_id
        log['tweet_ids'].first
      end

      def save_log
        File.write(file_name, log.to_yaml)
      end
    end
  end
end
