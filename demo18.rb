require 'rubygems'
require 'bundler/setup'

require 'bunny'

conn = Bunny.new
conn.start

channel = conn.create_channel

queue_options = {
  :arguments => {
    'x-dead-letter-exchange' => 'demo.rejected',
    'x-dead-letter-routing-key' => 'demo.rejected-from.topic-exchange-with-dlx'
  }
}

exchange = channel.topic('demo.topic-exchange-with-dlx')

q = channel.queue('', queue_options).bind(exchange, :routing_key => '#')

q.subscribe(:manual_ack => true) do |delivery_info, metadata, payload|
  puts payload
  sleep 2
  channel.reject delivery_info.delivery_tag, true
end

sleep
