require 'bunny'

conn = Bunny.new
conn.start

ch = conn.create_channel

class FibonacciServer

  def initialize(ch)
    @ch = ch
  end

  def start(queue_name)
    @q = @ch.queue(queue_name)
    @x = @ch.default_exchange

    @q.subscribe do |delivery_info, properties, payload|
      puts "Received: #{ payload }"
      r = self.class.repeat_it(payload)

      @x.publish(r.to_s, :routing_key => properties.reply_to, :correlation_id => properties.correlation_id)
    end
  end

  def self.repeat_it(phrase)
    [phrase, phrase].join(' ')
  end
end

begin
  server = FibonacciServer.new(ch)
  puts 'Waiting for RPC requests'
  server.start('demo.repeater')
rescue Interrupt => _
  ch.close
  conn.close
end

sleep
