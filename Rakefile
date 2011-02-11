require 'yaml'
require 'ap'

ROOT      = Dir.pwd
APP_NAME  = ENV["APP"] || ROOT.split("/").last
CONF_PATH = "torquebox.yml"
YAML_PATH = "#{APP_NAME}-knob.yml"
DEPL_PATH = "#{ENV["JBOSS_HOME"]}/server/#{ENV["JBOSS_CONF"] || "node1"}/farm/#{YAML_PATH}"

def lnr(msg = nil, chr = "=", qty = 120)
  puts msg ? "[ #{msg} ]".center(qty, chr) : chr * qty
end

def cmd(str)
  puts "Running [ #{str} ] ..."
  system(str)
  puts "Done."
end

def descriptor_hash
  {
    "application" => {
      "RACK_ROOT" => ROOT,
      "RACK_ENV" => ENV["RACK_ENV"] || "development",
    },
    "web" => {
      "context" => ENV["CONTEXT"] || "/#{APP_NAME}"
    }
  }
end

task :yaml do
  File.open(CONF_PATH, 'w') { |f| f.puts descriptor_hash.to_yaml }
end

desc "Deploy"
task :d => :yaml do
  system 'clear'
  lnr "Deploying [#{APP_NAME}] into [#{DEPL_PATH}]"
  ap descriptor_hash
  cmd %{cp #{CONF_PATH} #{DEPL_PATH}}
  lnr "Finished."
end

desc "Undeploy"
task :u do
  system 'clear'
  lnr "Undeploying [#{APP_NAME}] from [#{DEPL_PATH}]"
  cmd %{rm #{DEPL_PATH}}
  lnr "Finished."
end
    
  
