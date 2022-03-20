#!/usr/bin/env ruby
# Id$ nonnax 2022-03-10 23:40:40 +0800
require 'rubytools/noko_party'
require 'pp'

ROOT='https://1lib.ph'

q,page=ARGV
page||=1
@doc=NokoParty.get("#{ROOT}/s/#{q}?yearFrom=2015&page=#{page}")

def scrape
  valid=nil
  
  @doc.search('tr.bookRow').map do |res|
    valid=
    res.search('.//td/h3/a', '.cover').map.with_index do |td, i|
      td.name=='a' ? [td.text, td[:href]] : td['data-src']
    end
    valid.flatten
  end
  
end

scrape.each_with_index do |r,i|
  title, h, im = r
  h= h.prepend ROOT
  image= "![#{title}](#{im})"  
  post=<<~___
    [#{image}](#{h}){:target='_blank'}
    [#{title}](#{h}){:target='_blank'}
  ___
  puts post
  puts
end
