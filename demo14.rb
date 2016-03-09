require 'rubygems'
require 'bundler/setup'

require 'bunny'
require 'faker'
require 'securerandom'

conn = Bunny.new
conn.start
channel = conn.create_channel

# Source: https://gist.github.com/carlhoerberg/96eb730f4c533f61a856 (mostly)
class RepeaterClient
  def initialize(ch, server_queue)
    @x              = ch.default_exchange
    @reply_queue    = ch.queue('', :exclusive => true)
    @server_queue   = server_queue

    @results = Hash.new { |h,k| h[k] = Queue.new }
    @reply_queue.subscribe(block: false) do |delivery_info, properties, payload|
      @results[properties[:correlation_id]].push(payload)
    end
  end

  def call(phrase)
    correlation_id = SecureRandom.uuid

    @x.publish(phrase.to_s,
               :routing_key    => @server_queue,
               :correlation_id => correlation_id,
               :reply_to       => @reply_queue.name)

    result = @results[correlation_id].pop
    @results.delete correlation_id # to prevent memory leak
    result
  end
end


repeater = RepeaterClient.new(channel, 'demo.repeater')

begin
  loop do
    puts "Press enter"
    gets
    color = Faker::Color.color_name
    r = repeater.call(color)
    puts r
  end
rescue Interrupt => _
  channel.close
  conn.close
end
