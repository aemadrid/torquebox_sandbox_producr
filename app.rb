require 'date'
require 'rubygems'
require "bundler/setup"
require 'sinatra'
require 'org.torquebox.torquebox-messaging-client'

class Perf
  class << self
    def data(time)
      @cnt  ||= 0
      @time ||= 0.0
      @avg  ||= 0.0
      
      @cnt += 1
      @time += time
      @avg = @cnt / @time
      
      '%.2f rps / %i rs / %.2f secs' % [@avg, @cnt, @time]
    end
  end
end
  
get '/' do
  "Hello Producr TorqueBox!"
end

get '/upcase/:term' do
  queue = TorqueBox::Messaging::Queue.new("/queues/upcase")
  puts "Producr :: Getting upcased term [#{params[:term]}]"
  time = Time.now
  result = queue.publish_and_receive params[:term], :timeout => 1000
  time = Time.now - time
  puts "Producr :: Got upcased term [#{result}] #{result.inspect} (#{result.class.name}) in #{'%.2f' % time} secs (#{Perf.data(time)})"
  result
end