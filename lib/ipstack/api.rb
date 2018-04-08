require 'net/http'
require 'openssl'
require 'json'

require 'pry'

module Ipstack
  class API
    # Make sure we can access parameters of the object
    attr_accessor :api_url, :content_type, :access_key, :optionals, :params_uri
    # IP Address	[Required] Any IPv4 or IPv6 address; you can also enter a domain URL to have ipstack resolve the domain to the underlying IP address.
    # access_key	[Required] Your API Access Key.
    # fields	[optional] Set to your preferred output field(s) according to the Specify Output Fields section.
    # hostname	[optional] Set to 1 to enable Hostname Lookup.
    # security	[optional] Set to 1 to enable the Security module.
    # language	[optional] Set to a 2-letter language code according to the Specify Output Language section to change output language.
    # callback	[optional] Specify a JSONP callback function name according to the JSONP Callbacks section.
    # output	[optional] Set to json or xml to choose between output formats.
    def initialize(optionals = {}, access_key = ENV['IPSTACK_ACCESS_KEY'])
      @api_url = 'http://api.ipstack.com/'
      raise ArgumentError, '\'access_key\' (api key) cannot be nil. Obtain your key from https://ipstack.com/quickstart and set it as ENV[\'IPSTACK_ACCESS_KEY\']' if access_key.nil? || access_key == ''
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
      request = Net::HTTP::Get.new(query_ips.nil? || query_ips == '' ? "/check#{object.params_uri}" : "/#{query_ips}#{object.params_uri}")
      response = http.request(request)
      case response
      when Net::HTTPSuccess
        object.optionals[:output] == 'xml' ? Nokogiri::XML(response.body) : JSON.parse(response.body)
      else
        return response
        #"HTTP Error: #{response.code} #{response.message} : #{response.body}"
      end
    end

  end
end


