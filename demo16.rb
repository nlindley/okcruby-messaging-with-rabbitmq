require 'rubygems'
require 'bundler/setup'

require 'bunny'

conn = Bunny.new
conn.start

channel = conn.create_channel
exchange = channel.topic('demo.topic-exchange')
q = channel.queue().bind(exchange, :routing_key => '#')

q.subscribe(:manual_ack => true) do |delivery_info, metadata, payload|
  puts "Redelivered? #{ delivery_info[:redelivered] }"
  puts payload
  sleep 2
  channel.reject delivery_info.delivery_tag, true
end

sleep
