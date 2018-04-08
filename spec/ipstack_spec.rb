require 'spec_helper'

RSpec.describe Ipstack::API do

  describe 'Generate Object (.new)' do
    raise("ENV['IPSTACK_ACCESS_KEY'] is missing, these tests won't function properly...") if ENV['IPSTACK_ACCESS_KEY'].nil? || ENV['IPSTACK_ACCESS_KEY'] == ''

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
    it "can reach /IP endpoint" do
      api_request_object = Ipstack::API.new()
      # Requires you to have at least one zone for your user/group
      expect(Ipstack::API.make_request(api_request_object, '10.226.242.218').class.name).to eq('Hash')
    end



  end

end
