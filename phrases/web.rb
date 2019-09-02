module Phrases
  class Web
    def call(env)
      request = Rack::Request.new(env)
      params = Rack::Utils.parse_query(request.query_string)
      start_with = params['start_with'] || params['empezar_con']
      words = params['words'].to_i || params['palabras'].to_i

      user = request.path.gsub(/\/+/, '')
      file_name = "data/#{user}.yml"
      file_name = if File.exists?(file_name)
        file_name
      else
        Phrases::Markov::Builder::DEFAULT_FILE_NAME
      end

      response = Phrases::Markov::Generator.new(file_name: file_name, start_with: start_with, words_amount: words)
                                           .generate
                                           .join(' ')
                                           .capitalize
                                           .concat('.')

      [200, {'Content-Type' => 'text/plain', 'Content-Size' => response.size.to_s}, [response]]
    end
  end
end
