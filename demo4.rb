require 'rubygems'
require 'bundler/setup'

require 'bunny'

conn = Bunny.new
conn.start

channel = conn.create_channel

channel.queue('demo', :auto_delete => false).subscribe do |delivery_info, metadata, payload|
  sleep 10
  puts payload
end

sleep
