#!/usr/bin/env ruby
# Id$ nonnax 2022-03-28 17:47:15 +0800
require 'erb'

q, = ARGV

def _render(t, b=binding)
  ERB.new(t).result(b)
end

IO.popen(['./kpage', q, '1'], &:read)

t_layout=File.expand_path('views/layout.erb', __dir__)
t=File.expand_path('kpage.html', __dir__)
t=IO.read(t)
l=IO.read(t_layout)

html=[t, l].inject(){|text, t| _render(t){text}}

puts html
