# frozen_string_literal: true

module MetricaApi
  # Yandex Metrica response parser
  module Response

    module_function

    def parse(response)
      if response.is_a?(Array)
        response.map { |r| parse(r) }
      elsif response.is_a?(String)
        JSON.parse(response)
      else
        response
      end
    rescue JSON::ParserError
      response
    end

    def json_parse(response)
      JSON.parse(response)
    end

  end
end
