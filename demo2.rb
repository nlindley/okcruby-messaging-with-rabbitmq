require 'rubygems'
require 'bundler/setup'

require 'bunny'

conn = Bunny.new
conn.start

channel = conn.create_channel

channel.queue('demo', :auto_delete => true).subscribe do |delivery_info, metadata, payload|
  puts payload
end

sleep
