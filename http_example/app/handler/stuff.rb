require 'json'

java_import 'ratpack.http.client.HttpClient'
java_import 'ratpack.jackson.Jackson'

module Handler
  class Stuff < Base
    URL = java.net.URI.new('http://swapi.co/api/people/?search=bb8')

    def handle
      call_api.then do |resp|
        render(resp)
      end
    end

    private

    def call_api
      client.get(URL)
    end

    def client
      @client ||= ctx.get(HttpClient.java_class)
    end

    def render(resp)
      body = JSON.parse(resp.get_body.get_text)
      ctx.render(Jackson.json(body))
    end
  end
end
