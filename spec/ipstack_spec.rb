require 'spec_helper'

RSpec.describe Ipstack::API do

  describe 'Generate Object (.new)' do
    raise('ENV[\'IPSTACK_ACCESS_KEY\'] is missing, these tests won\'t function properly...') if ENV['IPSTACK_ACCESS_KEY'].nil? || ENV['IPSTACK_ACCESS_KEY'] == ''
    it "raise with missing ENV['IPSTACK_ACCESS_KEY']" do
      expect {Ipstack::API.new({},nil)}.to raise_error(ArgumentError)
      expect {Ipstack::API.new({},'')}.to raise_error(ArgumentError)
    end
  end
  describe 'Make Requests (.make_request)' do
    it "can reach /check endpoint without any params" do
      api_request_object = Ipstack::API.new()
      expect(Ipstack::API.make_request(api_request_object).class.name).to eq('Hash')
    end
    it "can reach /{IP} endpoint" do
      api_request_object = Ipstack::API.new()
      # Requires you to have at least one zone for your user/group
      expect(Ipstack::API.make_request(api_request_object, '10.226.242.218').class.name).to eq('Hash')
    end
  end

  describe 'Check Method' do
    it 'returns valid hash from json conversion' do
      expect(Ipstack::API.check).to have_key('ip')
    end
    it 'returns valid Nokogiri from xml conversion' do
      expect(Ipstack::API.check({output: 'xml'}).xpath('//result').children.any?).to eq(true)
    end
    it 'errors with string as first parameter' do
      expect{Ipstack::API.check('test')}.to raise_error(ArgumentError)
    end
  end

  describe 'Standard Method' do
    it 'returns valid hash from json conversion' do
      expect(Ipstack::API.standard('134.201.250.155')).to have_key('ip')
    end
    it 'returns valid Nokogiri from xml conversion' do
      expect(Ipstack::API.standard('134.201.250.155',{output: 'xml'}).xpath('//result').children.any?).to eq(true)
    end
    it 'errors with no or blank IP as first parameter' do
      expect{Ipstack::API.standard({})}.to raise_error(ArgumentError)
      expect{Ipstack::API.standard('')}.to raise_error(ArgumentError)
    end
  end

  describe 'Bulk Method' do
    # No License for bulk tests...
    it 'errors with no or blank IP as first parameter' do
      expect{Ipstack::API.bulk({})}.to raise_error(ArgumentError)
      expect{Ipstack::API.bulk('')}.to raise_error(ArgumentError)
    end
  end


end
