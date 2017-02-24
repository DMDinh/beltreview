class UsersController < ApplicationController
  before_action :status, except:[:index, :create, :login, :logout, :edit, :update, :show]

  def index
  end

  def event
    @event = Event.find(params[:id])
    @users = @event.users
    @comments = @event.comments
  end

  def events
    @user = User.find(session[:user_id])
    @myjoins = @user.joins
    @myhosts = @user.events
    @myevents = @user.myevents
    @state = Event.where(state: @user.state)
    @others = Event.where.not(state: @user.state)
  end

  def eventedit
    @event = Event.find(params[:id])
  end

  def eventupdate
    @event = Event.find(params[:id]).update(name: params[:name], date: params[:date], city: params[:city], state: params[:state])
    redirect_to '/events'
  end

  def join
    @user = User.find(session[:user_id])
    @event = Event.find(params[:id])
    Join.create(user: @user, event: @event)
    redirect_to "/events"
  end

  def unjoin
    @user = User.find(session[:user_id])
    @event = Event.find(params[:id])
    Join.where(user_id:session[:user_id], event_id:params[:id]).destroy_all
    redirect_to "/events"
  end

  def users
    @user = User.find(session[:user_id])
    @users = User.all
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def info
    @user = User.find(params[:id])
    @myevents = @user.events
    @myattends = @user.myevents

  end

  def comment
    @user = User.find(session[:user_id])
    @event = Event.find(params[:id])
    comment = Comment.create(message: params[:comment], user: @user, event: @event)
    redirect_to "/events"
  end

  def addevent
    # @event = (ename= params[:ename], date= params[:date], city= params[:city], state= params[:state])
    # render json: @event
    @user = User.find(params[:id])
    Event.create(name: params[:name], date: params[:date], city: params[:city], state: params[:state], user: @user)
    redirect_to '/events'
  end


  def create

    user = User.create(fname: params[:fname], lname: params[:lname], email: params[:email], city: params[:city], state: params[:state], password: params[:password], password_confirmation: params[:password_confirmation])
    if user.valid?
      session[:id] = user[:id]
      redirect_to '/events'
    else
      flash[:msg] = user.errors.full_messages.to_sentence
      redirect_to '/'
    end
  end

  def update
    @user = User.find(params[:id]).update(fname: params[:fname], lname: params[:lname], email: params[:email], city: params[:city], state: params[:state], password: params[:password], password_confirmation: params[:password_confirmation])
    redirect_to '/events'
  end

  def login
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user[:id]
      redirect_to '/events'
    else
      flash[:msg] = "Either password or email was invalid. Please try again."
      redirect_to '/'
    end
  end

  def logout
    session.clear
    redirect_to "/"
  end

  def destroy
    @user = User.find(params[:id]).destroy
    redirect_to '/users'
  end


  private

  def status
    if !session[:user_id]
      redirect_to '/'
    else
    end
  end
end
