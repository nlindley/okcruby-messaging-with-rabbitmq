require 'rubygems'
require 'bundler/setup'

require 'bunny'
require 'faker'

conn = Bunny.new
conn.start

channel = conn.create_channel

exchange = channel.fanout('demo.fanout-exchange')

loop do
  puts "Press enter"
  gets
  exchange.publish(Faker::Color.color_name)
end
