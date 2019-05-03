# frozen_string_literal: true

require 'metrica_api'

describe 'Requests' do
  let(:access_token) { 'oauth_token' }

  describe 'Counters' do
    let(:api_object) { MetricaApi.counters(access_token) }

    it 'performs GET-request' do
      stub_request(
        :get,
        'https://api-metrika.yandex.net/management/v1/counters.json?some_param=some_value'
      ).with(headers: { 'Authorization' => 'OAuth oauth_token' })
        .to_return(body: '{"some_array": ["some", "items"], "some_number": 35}')

      expect(api_object.data(some_param: 'some_value')).to(
        eq('some_array' => %w[some items], 'some_number' => 35)
      )
    end
  end

  describe 'Reporting' do
    let(:api_object) { MetricaApi.reporting(access_token) }

    it 'performs GET-request' do
      stub_request(
        :get,
        'https://api-metrika.yandex.net/stat/v1/data.json?some_param=some_value'
      ).with(headers: { 'Authorization' => 'OAuth oauth_token' })
        .to_return(body: '{"some_array": ["some", "items"], "some_number": 35}')

      expect(api_object.data(some_param: 'some_value')).to(
        eq('some_array' => %w[some items], 'some_number' => 35)
      )
    end
  end

  describe 'Logger' do
    let(:logger) { double('Logger double', '<<': nil) }
    before { MetricaApi.logger = logger }
    after { MetricaApi.logger = nil }

    it 'logs requests' do
      stub_request(
        :get,
        'https://api-metrika.yandex.net/stat/v1/data.json?some_param=some_value'
      ).with(headers: { 'Authorization' => 'OAuth oauth_token' })
        .to_return(body: '{"some_array": ["some", "items"], "some_number": 35}')

      expect(logger).to(
        receive(:<<).with('https://api-metrika.yandex.net/stat/v1/data.json?some_param=some_value')
      )
      expect(logger).to(
        receive(:<<).with('{"some_array": ["some", "items"], "some_number": 35}')
      )

      MetricaApi.reporting(access_token).data(some_param: 'some_value')
    end
  end
end
