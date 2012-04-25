SPEC_DIR = File.dirname(__FILE__)
lib_path = File.expand_path("#{SPEC_DIR}/../lib")
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)

require "stackrb"

require "fakeweb"
FakeWeb.allow_net_connect = false

require "pry"

# user by valid id (i.e. me)
content = (File.open "spec/responses/valid_user_by_id.json").read
FakeWeb.register_uri(:get, "http://api.stackexchange.com/2.0/users/806689?order=desc&sort=reputation&site=stackoverflow", :body => content)

