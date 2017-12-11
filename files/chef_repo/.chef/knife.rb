current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                ENV['CHEF_USER'] #todo
client_key               '/etc/chef/keys/client/client.pem' #todo
validation_client_name   "#{ENV['CHEF_ORG']}-validator" #todo
validation_key           '/etc/chef/keys/client/validator.pem'
chef_server_url          "https://#{ENV['CHEF_SERVER']}/organizations/#{ENV['CHEF_ORG']}"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]