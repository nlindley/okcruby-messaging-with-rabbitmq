require 'rubygems'
require 'bundler/setup'

require 'bunny'

conn = Bunny.new
conn.start

channel = conn.create_channel

exchange = channel.topic('demo.topic-exchange')

blue_queue = channel.queue().bind(exchange, :routing_key => 'make-art.blue.*')
paint_queue = channel.queue().bind(exchange, :routing_key => 'make-art.*.paint')
art_queue = channel.queue().bind(exchange, :routing_key => 'make-art.#')

blue_queue.subscribe do |delivery_info, metadata, payload|
  puts "Blue! #{ payload }"
end

paint_queue.subscribe do |delivery_info, metadata, payload|
  puts "Paint! #{ payload }"
end

art_queue.subscribe do |delivery_info, metadata, payload|
  puts "Art!!!"
end

sleep
