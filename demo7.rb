require 'rubygems'
require 'bundler/setup'

require 'bunny'
require 'faker'

conn = Bunny.new
conn.start

channel = conn.create_channel

q = channel.queue('demo', :durable => true)

loop do
  puts "Press enter"
  gets
  q.publish(Faker::Color.color_name)
end
