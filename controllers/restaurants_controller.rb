require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative ('../models/burger.rb')
require_relative ('../models/day.rb')
require_relative ('../models/restaurant.rb')


# show all restaurants
get '/restaurants' do
  @restaurants = Restaurant.all()
  @days = Day.all()
  erb(:"restaurants/index")
end

# form to add restaurant
get '/restaurants/new' do
  @restaurants = Restaurant.all()
  @days = Day.all()
  erb(:"restaurants/new")
end

# actually add burger from form to db
post '/restaurants' do
  restaurant = Restaurant.new(params)
  restaurant.save()
  redirect to ('/restaurants/new')
end

# # form to edit burger
# get '/burgers/:id/edit' do
#   @days = Day.all()
#   @burger = Burger.find( params[:id])
#   erb(:"burgers/edit")
# end

# # acutally update burger details to db
# post '/burgers/:id' do
#   @burger = Burger.update(params)
#   redirect to ('/burgers')
# end

# show a burgers for a particular restaurant
get '/restaurants/:id/burgers' do
  @days = Day.all()
  @restaurant = Restaurant.find(params[:id])
  @burgers = @restaurant.burgers()
  @emptys = Empty.all
  erb(:"restaurants/show")
end


# # delete a burger from the db
# post '/burgers/:id/delete' do
#   Burger.delete(params[:id])
#   redirect to ('/burgers')
# end












