require 'sinatra/base'
require './lib/spaces'

class BnB < Sinatra::Base
  get '/' do
    'Hello World'
  end

  get '/spaces/new' do
    erb(:'spaces/new')
  end

  post '/spaces' do
    p params
    @space = Space.create(name: params[:name], user_id: '1001',
      description: params[:description], price: params[:price], from: params[:from], to: params[:to])
    redirect('/spaces')
  end

  get '/spaces' do
    @spaces = Space.all
    erb(:'spaces/list')
  end



  run! if app_file == $0

end
