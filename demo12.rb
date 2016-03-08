require 'rubygems'
require 'bundler/setup'

require 'bunny'
require 'faker'

conn = Bunny.new
conn.start

channel = conn.create_channel

exchange = channel.topic('demo.topic-exchange')

loop do

  puts "What do you want to do?"
  puts "1 Paint"
  puts "2 Draw"
  puts "3 Color"
  puts "4 Trace"

  line = gets

  color = Faker::Color.color_name

  action = case line.strip
  when '1'
    'paint'
  when '2'
    'draw'
  when '3'
    'color'
  when '4'
    'trace'
  else
    'experiment'
  end

  routing_key = "make-art.#{ color }.#{ action }"

  exchange.publish(color, :routing_key => routing_key)
end
