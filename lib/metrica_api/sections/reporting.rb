# frozen_string_literal: true

class MetricaApi
  module Sections
    # Reporting API
    class Reporting

      def initialize(token)
        @session = Session.new(token)
      end

      def data(params)
        call('data', params)
      end

      def drilldown(params)
        call('data/drilldown', params)
      end

      private

      attr_reader :session

      def call(method, params)
        session.call({ api_section: 'stat', method: method }, params)
      end

    end
  end
end
