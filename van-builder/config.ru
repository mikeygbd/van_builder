require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use PartsController
use WishlistPartsController
use UsersController
run ApplicationController


heroku create --buildpack https://github.com/heroku/heroku-buildpack-ruby.git
