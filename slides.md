# Messaging with RabbitMQ

---

# What is RabbitMQ

---

# AMQP

---

# Installation

---

### Installation

# [fit] ¯\\\_(ツ)\_/¯

^ I’ve only installed RabbitMQ in OS X, but if you can run Erlang, you can run RabbitMQ.

---

```sh
brew install rabbitmq
rabbitmq-server -detached
```

^ Here’s the easiest way to get things going in OS X. Passing the detached option
with only a single dash for some reason, will run the server as a daemon.

---

# Connect

## (Channels)

---

# Connect (Channels)

```ruby
conn = Bunny.new
conn.start

channel = conn.create_channel

sleep
```

^ First we have to get a connection to the server. This will be a single,
persistent connection. By default this will connect to you RabbitMQ server
running on localhost. If we want to use a remote server, we just pass a
URI to the constructor.

---

# Connect (Channels)

```ruby
conn = Bunny.new "amqp://u:p@example.com:5672/%2f"
conn.start

channel = conn.create_channel

sleep
```

^ Next we need to create a channel. From here you can just think of a channel
as a virtual connection, and we won’t be dealing with raw connections directly.
We’ll revisit why we’re using channels instead a little later.

^ Now normally I get lazy and just name the variable ch, but for clarity and
brevity, we’ll assume there’s a channel variable available to us for the Next
few demos.

^ Now that we are to a point where we can actually do something, let’s do something.

---

# [fit] Publish

^ The most basic things you’ll be doing are publishing messages and consuming
messages. Since we need _something_ to consume, we’ll start by publishing. This
may not sound intuitive at first, but depending on how your app works, there’s
a good chance you’ll end up publishing a lot more than you consume.

---

# Consume

---

# Exchanges

---

## Direct

### Default

---

# Delayed Queues

---

# Multiple Processes

---

# Questions?

## @nlindley
