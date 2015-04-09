require 'nokogiri'
require 'net/http'
#require 'open-uri'

#redirects url once
#if the url multi-redirects, use this function until returns nil
#and don't forget to check for infinite redirection
def url_redirect (url)
	return Net::HTTP.get_response(URI.parse(url))['location']
end

#open url with Nokogiri
def url_open (url)
	#split url into 2 parts for Net:HTTP below
	host = url[/(?<=http:\/\/)[^\/]+/]
	path = url.sub('http://', "").sub(host, "")

	return Nokogiri::HTML(Net::HTTP.get(host, path))
end

#process webpage content
def webpage_formatting (contents)
	#remove tags like <script> because they mess up with Nokogiri
	#add other tags to this variable if unwanted stuff show up in Nokogiri::HTML.text
	to_be_removed = 'script, style'
	contents.css(to_be_removed).each {|node| node.remove}

	words = contents.text.squeeze("\s").split("\s")
	#remove punctuations in front and/or end of words
	words.each do |word|
		word.sub!(/^[\[(\"]/, "")
		word.sub!(/\W+$/, "")
		#uncomment the following line if you want this program to be case insensitive
		#word.downcase
	end
	#remove strings with pure punctuation
	words.delete_if {|empty| empty == ""}

	return words
end

#analysis of word frequency
def word_frequency (words)
	h = Hash.new(0)

	words.each do |word|
		h[word] += 1
	end

	return h.to_a.sort{|a, b| a[1] <=> b[1]}
end

#main
link = 'http://en.wikipedia.org/wiki/Special:Random'
page_count = 10
n_of_most_frequent = 100
webpage_contents = []

for count in 1..page_count
	target_url = url_redirect(link)
	webpage_contents.concat(webpage_formatting(url_open(target_url)))
end

p word_frequency(webpage_contents).reverse.slice(0, n_of_most_frequent).to_h