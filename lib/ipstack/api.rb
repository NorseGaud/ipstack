require 'net/http'
require 'openssl'
require 'json'
require 'nokogiri'

module Ipstack
  class API
    # Make sure we can access parameters of the object
    attr_accessor :api_url, :content_type, :access_key, :optionals, :params_uri, :return_raw
    def initialize(optionals = {}, access_key = ENV['IPSTACK_ACCESS_KEY'])

      raise ArgumentError, 'Requires a hash of optional values found on https://ipstack.com/documentation' unless optionals.is_a?(Hash)
      raise ArgumentError, '\'access_key\' (api key) cannot be nil. Obtain your key from https://ipstack.com/quickstart and set it as ENV[\'IPSTACK_ACCESS_KEY\']' if access_key.nil? || access_key == ''

      @return_raw = optionals[:return_raw]
      optionals.delete(:return_raw) # remove it from optionals since we each optionals for our url params

      @api_url = 'http://api.ipstack.com/'
      @access_key = access_key
      @params_uri = "?access_key=#{access_key}"
      # Set params_uri with each non-nil optionals key/value
      optionals.each{ |param_name,param_value| @params_uri << "&#{param_name}=#{param_value}" unless param_value.nil? }
      @optionals = optionals
    end
    def self.make_request(object, query_ips = nil)
      url = URI(object.api_url)
      http = Net::HTTP.new(url.host,url.port)
      # TODO: HTTP/HTTPS support
      #http.use_ssl = false
      # https.verify_mode = OpenSSL::SSL::VERIFY_NONE # SSL not signed? Don't care!
      request = Net::HTTP::Get.new(query_ips.nil? || query_ips.empty? ? "/check#{object.params_uri}" : "/#{query_ips}#{object.params_uri}")
      response = http.request(request)
      case response
      when Net::HTTPSuccess
        if object.return_raw
          response.body
        else
          object.optionals[:output] == 'xml' ? Nokogiri::XML(response.body) : JSON.parse(response.body)
        end
      else
        return response
        #"HTTP Error: #{response.code} #{response.message} : #{response.body}"
      end
    end

    def self.standard(ip, optionals = {})
      api_request_object = Ipstack::API.new(optionals)
      raise ArgumentError, 'Requires a single IP as first parameter' if ip.nil? || ip.empty? || ip.is_a?(Hash)
      Ipstack::API.make_request(api_request_object,ip)
    end

    def self.bulk(ips, optionals = {})
      api_request_object = Ipstack::API.new(optionals)
      raise ArgumentError, 'Requires a list of IPs comma separated as first parameter' if ips.nil? || ips.empty? || ip.is_a?(Hash) || !( ips.include?(',') && ips.match(/((25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?)(,\n|,?$))/) )
      Ipstack::API.make_request(api_request_object,ips)
    end

    def self.check(optionals = {})
      raise ArgumentError,'Only optionals hash allowed as first parameter' unless optionals.is_a?(Hash) || optionals.empty?
      api_request_object = Ipstack::API.new(optionals)
      Ipstack::API.make_request(api_request_object)
    end

  end
end


