# frozen_string_literal: true

class MetricaApi
  module Sections
    # Couters API
    class Counters

      def initialize(token)
        @session = Session.new(token)
      end

      def data(params = {})
        session.call({ api_section: 'management', method: 'counters' }, params)
      end

      private

      attr_reader :session

    end
  end
end
