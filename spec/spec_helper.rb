require 'rubygems'
require 'capybara/rspec'
require 'rack/test'

# All our specs should require 'spec_helper' (this file)

# If RACK_ENV isn't set, set it to 'test'.  Sinatra defaults to development,
# so we have to override that unless we want to set RACK_ENV=test from the
# command line when we run rake spec.  That's tedious, so do it here.
ENV['RACK_ENV'] ||= 'test'



require File.expand_path("../../config/environment", __FILE__)

Capybara.app = Sinatra::Application #think this is what they mean on installation of non-rails
                       #app here: https://github.com/jnicklas/capybara#drivers
# exec("createdb #{DB_NAME}")
# exec("bundle exec rake db:migrate")
# exec("bundle exec rake db:seed")

# at_exit(exec( "dropdb #{DB_NAME}" ))
configure do
  # See: http://www.sinatrarb.com/faq.html#sessions
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET'] || 'this is a secret shhhhh'

  # Set the views to 
  # puts '*'*200
  # puts Sinatra::Application.root
  set :views, File.join( File.expand_path("../../", __FILE__), "app", "views")
end

