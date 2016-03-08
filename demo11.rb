require 'rubygems'
require 'bundler/setup'

require 'bunny'

conn = Bunny.new
conn.start

channel = conn.create_channel

exchange = channel.direct('demo.direct-exchange')

q1 = channel.queue().bind(exchange, :routing_key => 'even')
q2 = channel.queue().bind(exchange, :routing_key => 'odd')

q1.subscribe do |delivery_info, metadata, payload|
  puts "Even: #{ payload }"
end

q2.subscribe do |delivery_info, metadata, payload|
  puts "Odd: #{ payload }"
end

sleep
