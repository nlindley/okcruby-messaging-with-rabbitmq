require 'rubygems'
require 'bundler/setup'

require 'bunny'

conn = Bunny.new
conn.start

channel = conn.create_channel

exchange = channel.fanout('demo.fanout-exchange')
q = channel.queue().bind(exchange)

q.subscribe(:manual_ack => true) do |delivery_info, metadata, payload|
  puts payload
  channel.ack delivery_info.delivery_tag
end

sleep
