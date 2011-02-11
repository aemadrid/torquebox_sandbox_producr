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
  result = queue.publish_and_receive params[:term], :timeout => 1000
  puts "Producr :: Got upcased term [#{result}] #{result.inspect} (#{result.class.name})"
  if result.nil?
    "[term:#{params[:term]}|upcased:nil]"
  else
    "[term:#{params[:term]}|upcased:#{result}]"
  end
end
