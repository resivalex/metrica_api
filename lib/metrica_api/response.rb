# frozen_string_literal: true

class MetricaApi
  # Yandex Metrica response parser
  class Response

    def self.parse(response)
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

  end
end
