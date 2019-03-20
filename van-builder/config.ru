require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use PostsController
use PartsController
use WishlistPartsController
use UsersController
run ApplicationController
