#!/usr/bin/env ruby
# Id$ nonnax 2022-03-10 23:40:40 +0800
require 'rubytools/noko_party'

ROOT='https://1lib.ph'

q,page=ARGV
page||=1
@doc=NokoParty.get("#{ROOT}/s/#{q}?yearFrom=2015&page=#{page}")
# @doc.search('//td/h3/a').each{|e|

# @doc.search('//h3/a').each{|e|
  # p [e[:href], e.at_xpath('//img')] #.['data-src']
  # puts [ e.text, 'https://1lib.ph' + e[:href] ].join("\t")
# }

def scrape
  @doc.search('//div[@class="z-book-precover"]/a').map{|e| 
    [ e[:href], e.at_xpath('img')['data-src'] ]
  }
end

scrape.each_with_index do |r,i|
  h, im = r
  h=h.prepend ROOT
  image= "![#{h}](#{im})"
  puts "[#{image}](#{h}){:target='_blank'}"
end
