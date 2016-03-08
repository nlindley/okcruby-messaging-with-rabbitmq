require 'rubygems'
require 'bundler/setup'

require 'bunny'
require 'faker'

conn = Bunny.new
conn.start

channel = conn.create_channel

exchange = channel.direct('demo.direct-exchange')

def even_or_odd(color)
  color.length % 2 == 0 ? 'even' : 'odd'
end

loop do
  puts "Press enter"
  gets
  color = Faker::Color.color_name
  exchange.publish(Faker::Color.color_name, :routing_key => even_or_odd(color))
end
