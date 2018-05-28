class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :home
  end

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/registrations' do
    @user = User.create(name: params[:name], email: params[:email], password: params[:password])
    @user.save
    session[:user_id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do

    @user = User.find(params[:id])

    erb :'sessions/login'
  end

  post '/sessions' do

    redirect '/users/home'
  end

  get '/sessions/logout' do

    redirect '/'
  end

  get '/users/home' do
    @user = User.find(session[:user_id])

    erb :'/users/home'
  end

end
