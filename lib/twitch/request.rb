module Twitch
  module Request

    def required_headers
      {'Client-ID' => @client_id,
      'Accept' => 'application/vnd.twitchtv.v5+json'}
    end

    def build_query_string(options)
      query = "?"
      options.each do |key, value|
        query += "#{key}=#{value.to_s.gsub(" ", "+")}&"
      end
      query = query[0...-1]
    end

    def get(url, data={})
      data[:headers] = data[:headers] || {}
      data[:headers].merge!(required_headers)
      @adapter.get(url, data)
    end

    def post(url, data)
      @adapter.post(url, :body => data)
    end

    def put(url, data={})
      @adapter.put(url, :body => data, :headers => {
          'Accept' => 'application/json',
          'Content-Type' => 'application/json',
      })
    end

    def delete(url)
      @adapter.delete(url)
    end
  end
end
