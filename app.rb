require 'date'
require 'rubygems'
require "bundler/setup"
require 'sinatra'
require 'org.torquebox.torquebox-messaging-client'

get '/' do
  "Hello Producr TorqueBox!"
end

get '/upcase/:term' do
  queue = TorqueBox::Messaging::Queue.new("/queues/upcase")
  puts "Producr :: Getting upcased term [#{params[:term]}]"
  time = Time.now
  result = queue.publish_and_receive params[:term], :timeout => 1000
  time = Time.now - time
  puts "Producr :: Got upcased term [#{result}] #{result.inspect} (#{result.class.name}) in #{'%.2f' % time} secs"
  result
end