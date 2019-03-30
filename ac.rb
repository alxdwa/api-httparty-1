require 'httparty'
class StackSearch
  include HTTParty

  base_uri 'https://api.stackexchange.com'

  def search
    puts "What do you want to search?"
    input = gets.chomp
    puts "Do you want to sort by activity (A) or relevance (R)?"
    sort_by_input = gets.chomp
    until sort_by_input.downcase == "a" or sort_by_input.downcase == "r"
      puts "Please select (A)ctivity or (R)elevance"
      sort_by_input = gets.chomp
    end
    if sort_by_input.downcase == "a"
      sort_by = "relevance"
    elsif sort_by_input.downcase == "r"
      sort_by = "activity"
    end
    #basic search (title):
    # url = "/2.2/search?order=desc&sort=#{sort_by}&intitle=#{input}&site=stackoverflow"
    #advanced search:
    url = "/2.2/search/advanced?order=desc&sort=#{sort_by}&q=#{input}&site=stackoverflow"
    get_url = self.class.get(url)
    get_url.parsed_response
  end

  def display_results
    items = self.search["items"]
    if items.length == 0
      puts ""
      puts "Sorry, no results. Please try again."
      puts ""
    end

    i = 0
    while i < items.length
      puts ""
      puts items[i]["title"]
      puts items[i]["link"]
      puts ""
      puts "---------------------------------------------------------"
      i += 1
    end
  end

end

new_search = StackSearch.new
new_search.display_results

