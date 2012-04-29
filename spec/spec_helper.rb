SPEC_DIR = File.dirname(__FILE__)
lib_path = File.expand_path("#{SPEC_DIR}/../lib")
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)

require "stackrb"

require "fakeweb"
require "fakeweb_matcher"
FakeWeb.allow_net_connect = false

require "pry"

# last 30 users
content = (File.open "spec/responses/last_30_users.json").read
FakeWeb.register_uri(:get, "http://api.stackexchange.com/2.0/users/?site=stackoverflow", :body => content)

# user by valid id (i.e. me)
content = (File.open "spec/responses/valid_user_by_id.json").read
FakeWeb.register_uri(:get, "http://api.stackexchange.com/2.0/users/806689?site=stackoverflow", :body => content)

# two users
content = (File.open "spec/responses/two_valid_users_by_id.json").read
FakeWeb.register_uri(:get, "http://api.stackexchange.com/2.0/users/806689;12345?site=stackoverflow", :body => content)

# user by invalid id
content = (File.open "spec/responses/invalid_user_by_id.json").read
FakeWeb.register_uri(:get, "http://api.stackexchange.com/2.0/users/-4?site=stackoverflow", :body => content)
