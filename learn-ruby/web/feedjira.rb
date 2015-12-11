require 'rubygems'
require 'feedjira'

feed = Feedjira::Feed.fetch_and_parse('http://rss.nytimes.com/services/xml/rss/nyt/Africa.xml')
puts "This feed's title is #{feed.title}"
puts "This feed's Web site is at #{feed.url}"

feed.entries.each do |item|
  puts item.title + "\n--\n" + item.summary + "\n\n"
end
