require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'pg'
require_relative "db/connection"

module Forum
  class Server < Sinatra::Base

    configure do
      register Sinatra::Reloader
      set :sessions, true
    end

    def current_user
      session[:user_id]
    end

    def logged_in?
      !current_user.nil?
    end

    get '/' do
      erb :homepage
    end

    get '/topics' do
      @topics = $db.exec_params("SELECT topic,popular 
                                FROM topics")
      erb :topics
    end

    post '/topics' do
      if logged_in?
        result = $db.exec_params("INSERT INTO topics (topic, popular, created_at) VALUES ($1, $2, CURRENT_TIMESTAMP)",[params[:new_topic], 0])

        redirect "/topics"
      else
        status 403
        "PERMISSION DENIED"
      end
    end 

    post '/users/login' do
      # get user from database with email and password
      @user = $db.exec_params("SELECT * FROM users WHERE email = $1 AND password = $2", [params[:email], params[:password]])
      
      if @user.first.nil?
        # if password is wrong redirect to homepage
        @message = "Invalid Login"
        erb :homepage
      else
        user_id = @user.first["id"]

        # save user_id into the session
        session[:user_id] = user_id
        # redirect somewhere
        redirect "/users/#{user_id}"
      end
    end

    get '/topics/:id' do
        @topic_name = $db.exec_params("SELECT * FROM topics WHERE id = $1;", [params[:id]]).first["topic"]
        erb :topic
    end

    post 'topics/:id' do
      topic_id = $db.exec_params("SELECT * FROM topics WHERE id = $1;", [params[:id]]).first["id"]      
      comments = $db.exec_params("INSERT INTO comments (topics_id,message,created_at) VALUES($1,$2,CURRENT_TIMESTAMP)RETURNING id", [topic_id, params[:message]])
      redirect "/topics/#{comments.first["id"]}"
    end

    post '/topics' do
      id = $db.exec_params("SELECT topic FROM topics WHERE topic = $1 RETURNING id;", [params[:topic]]).first
      redirect "/topics/#{id.first["id"]}"
    end

    get '/users' do
      @users = $db.exec_params("SELECT * FROM users;")
      erb :users
    end

    get '/users/:id' do
      # This should GET a user
      @user = $db.exec_params("SELECT * FROM users WHERE id = $1;", [params[:id]]).first
      erb :user
    end
          # LOG OUT
    delete '/users/login' do
      session[:user_id] = nil
      redirect '/'
    end

  end
end