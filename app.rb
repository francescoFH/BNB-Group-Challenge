require 'sinatra/base'
require 'sinatra/flash'
require './lib/user'
require './lib/space'
require './lib/booking'
require './database_connection_setup'

class MakersBnB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  configure do
    # allows sinatra to find my CSS stylesheet
    set :public_folder, File.expand_path('../public', __FILE__)
    set :views        , File.expand_path('../views', __FILE__)
    set :root         , File.dirname(__FILE__)
  end

  helpers do
    def current_space
      @current_space ||= Space.find(id: session[:space_id])
    end
  end

  before do
    @user = session[:user]
  end

  get '/' do
    erb :"user/new"
  end

  post '/user/new' do
    user = User.create(name: params[:name], email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect '/spaces'
    else
      flash[:notice] = "Email is taken. Please try another."
      redirect '/'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(email: params[:email], password: params[:password])

    if user
      session[:user_id] = user.id
      redirect '/spaces'
    else
      flash[:notice] = 'Please check your email or password.'
      redirect '/sessions/new'
    end
  end

  post '/sessions/destroy' do
    session.clear
    flash[:notice] = '>> You have signed out <<'
    redirect '/'
  end

  get '/spaces' do
    @user = User.find(id: session[:user_id])
    if session[:available] == nil
      @spaces = Space.all
    else
      @spaces = session[:available]
    end
    erb :'spaces/list'
  end

  post '/spaces/available' do
    session[:available] = Space.available(params['from'], params['to'])
    redirect '/spaces'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/spaces' do
    @space = Space.create(owner: session[:user_id],
      name: params[:name],
      description: params[:description],
      price: params[:price],
      from_date: params[:from],
      to_date: params[:to]
    )
    redirect '/spaces'
  end

  get '/spaces/:id/booking' do
    @space_id = params[:id]
    erb :'booking/new'
  end

  post '/spaces/:id/booking' do
    session[:space_id] = params[:id]
    Booking.create(
      space_name: current_space.name,
      booking_date: params[:date],
      total_price: current_space.price,
      name: @user.name, email: @user.email)
    redirect '/spaces'
  end

  get '/requests' do
    @requests = Booking.find(id: @user.id) 
    erb :requests
  end

  run! if app_file == $0
end
