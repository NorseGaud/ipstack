require 'ipstack/version'
require 'ipstack/api'

module Ipstack
  # https://ipstack.com/documentation

  def standard(ip, optionals = {})
    api_request_object = Ipstack::API.new(optionals)
    raise('Requires a single IP') if ip.include?(',')
    Ipstack::API.make_request(api_request_object,ip)
  end

  def bulk(ips, optionals = {})
    api_request_object = Ipstack::API.new(optionals)
    raise('Requires a list of IPs comma separated') unless ips.include?(',') && ips.match(/((25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?)(,\n|,?$))/)
    Ipstack::API.make_request(api_request_object,ips)
  end

  def check(optionals = {})
    api_request_object = Ipstack::API.new(optionals)
    Ipstack::API.make_request(api_request_object)
  end

end

