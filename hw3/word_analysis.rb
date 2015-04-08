require 'nokogiri'
require 'net/http'
#require 'open-uri'

#find target url
redirect_url = 'http://en.wikipedia.org/wiki/Special:Random'
url = Net::HTTP.get_response(URI.parse(redirect_url))['location']
p url

#split url into 2 parts for HTTP.get()
host = url[/(?<=http:\/\/)[^\/]+/]
p host
path = url.sub('http://', "").sub(host, "")
p path

#download target webpage
doc = Net::HTTP.get(host, path)
contents = Nokogiri::HTML(doc)

#process webpage content
contents.css('script, style').each {|node| node.remove}
words = contents.text.split("\s")
words.each do |word|
	word.sub!(/^[(\"]/, "")
	word.sub!(/\W+$/, "")
end
words.delete_if {|empty| empty == ""}
p words