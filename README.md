# (Unofficial) Ipstack Gem for API requests

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ipstack'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ipstack

## Usage

* All endpoints listed in https://ipstack.com/documentation can be found under Ipstack::API (.check, .standard, .bulk)
* Returned data is automatically converted into ruby usable forms
    * **JSON** will be passed through JSON.parse to return a Ruby data structure (a Hash)
    * **XML** through Nokogiri::XML
    * To disable this, you can set the _return_raw_ to true under optionals.
* Only basic checks are performed to be sure your parameters for the method are there or != nil/empty. You'll want to still rely on errors returned from the api itself. See documentation.

Here are examples:

```ruby

irb(main):008:0> Ipstack::API.check
=> {"ip"=>"73.152.49.135", "type"=>"ipv4", "continent_code"=>"NA", "continent_name"=>"North America", "country_code"=>"US", "country_name"=>"United States", "region_code"=>"VA", "region_name"=>"Virginia", "city"=>"Ashburn", "zip"=>"20147", "latitude"=>39.018, "longitude"=>-77.539, "location"=>{"geoname_id"=>4744870, "capital"=>"Washington D.C.", "languages"=>[{"code"=>"en", "name"=>"English", "native"=>"English"}], "country_flag"=>"http://assets.ipstack.com/flags/us.svg", "country_flag_emoji"=>"🇺🇸", "country_flagmoji_unicode"=>"U+1F1FA U+1F1F8", "calling_code"=>"1", "is_eu"=>false}}

irb(main):007:0> Ipstack::API.standard('134.201.250.155',{fields: 'city,region_name,zip'})
=> {"city"=>"Huntington Beach", "region_name"=>"California", "zip"=>"92648"}

irb(main):010:0> Ipstack::API.bulk('134.201.250.155,73.152.49.135',{fields: 'city,region_name,zip'})
=> {"success"=>false, "error"=>{"code"=>303, "type"=>"batch_not_supported_on_plan", "info"=>"Bulk requests are not supported on your plan. Please upgrade your subscription."}}

# Returning XML
  
irb(main):001:0> Ipstack::API.check({output: 'xml'})
=> #<Nokogiri::XML::Document:0x3fe9c31604f8 name="document" children=[#<Nokogiri::XML::Element:0x3fe9c31601b0 name="result" children=[#<Nokogiri::XML::Element:0x3fe9c315de9c name="ip" children=[#<Nokogiri::XML::Text:0x3fe9c315db68 "73.152.49.135">]>, #<Nokogiri::XML::Element:0x3fe9c315d30c . . .
     
# Returning raw json or xml
  
irb(main):002:0> Ipstack::API.check({return_raw: true})
=> "{\"ip\":\"73.152.49.135\",\"type\":\"ipv4\",\"continent_code\":\"NA\",\"continent_name\":\"North America\",\"country_code\":\"US\",\"country_name\":\"United States\",\"region_code\":\"VA\",\"region_name\":\"Virginia\",\"city\":\"Ashburn\",\"zip\":\"20147\",\"latitude\":39.018,\"longitude\":-77.539,\"location\":{\"geoname_id\":4744870,\"capital\":\"Washington D.C.\",\"languages\":[{\"code\":\"en\",\"name\":\"English\",\"native\":\"English\"}],\"country_flag\":\"http:\\/\\/assets.ipstack.com\\/flags\\/us.svg\",\"country_flag_emoji\":\"\\ud83c\\uddfa\\ud83c\\uddf8\",\"country_flag_emoji_unicode\":\"U+1F1FA U+1F1F8\",\"calling_code\":\"1\",\"is_eu\":false}}"

irb(main):003:0> Ipstack::API.standard('73.152.49.135',{output: 'xml', return_raw: true})
=> "<?xml version=\"1.0\"?>\n<result><ip>73.152.49.135</ip><type>ipv4</type><continent_code>NA</continent_code><continent_name>North America</continent_name><country_code>US</country_code><country_name>United States</country_name><region_code>VA</region_code><region_name>Virginia</region_name><city>Ashburn</city><zip>20147</zip><latitude>39.018</latitude><longitude>-77.539</longitude><location><geoname_id>4744870</geoname_id><capital>Washington D.C.</capital><languages><code>en</code><name>English</name><native>English</native></languages><country_flag>http://assets.ipstack.com/flags/us.svg</country_flag><country_flag_emoji>&#x1F1FA;&#x1F1F8;</country_flag_emoji><country_flag_emoji_unicode>U+1F1FA U+1F1F8</country_flag_emoji_unicode><calling_code>1</calling_code><is_eu></is_eu></location></result>\n"

```

## Contributing

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ipstack project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/NorseGaud/ipstack/blob/master/CODE_OF_CONDUCT.md).
