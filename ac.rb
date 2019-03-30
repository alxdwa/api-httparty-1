require 'httparty'
class StackSearch
  include HTTParty

  base_uri 'https://api.stackexchange.com'

  def search
    puts "what do you want to search?"
    input = gets.chomp
    url = "/2.2/search?order=desc&sort=activity&intitle=#{input}&site=stackoverflow"
    get_url = self.class.get(url)
    get_url.parsed_response
  end

end

new_search = StackSearch.new

items = new_search.search["items"]
i = 0
while i < items.length
  puts ""
  puts items[i]["title"]
  puts items[i]["link"]
  puts ""
  puts "---------------------------------------------------------"
  i += 1
end
