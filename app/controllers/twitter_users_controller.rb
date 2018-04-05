class TwitterUsersController < ApplicationController
  before_action :authenticate_user!


  def index
    @twitter_users = collection.popular_first
  end

  def show
    @twitter_user = resource
    @tweets = tweets_resource
  end

  def new
    @twitter_user = current_user.twitter_users.build
  end

  def create
    @twitter_user = current_user.twitter_users.build(user_params)
    if @twitter_user.save
      TwitterWorker.perform_async(user_params[:owner], @twitter_user.id)
      redirect_to twitter_users_path, flash: { success: 'New user is successfuly added!' }
    else
      flash[:danger].now = 'Your new user has invalid data!'
      render :new
    end
  end

  def edit
    @twitter_user = resource
  end

  def update
    @twitter_user = resource
    if @twitter_user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @twitter_user
    else
      flash[:danger] = 'Profile can`t be updated, improve the errors'
      render 'edit'
    end
  end

  def destroy
    resource.destroy
    flash[:success] = 'User deleted'
    redirect_to twitter_users_path
  end

  def export_to_exel
    @twitter_users = TwitterUser.all
    render xlsx: "export_users_to_exel.xlsx.axlsx", filename: "twitter_users.xlsx"
  end

  private

  def collection
    current_user.twitter_users.all
  end

  def resource
    collection.find(params[:id])
  end

  def user_params
    params.require(:twitter_user).permit(:name, :owner)
  end

  def tweets_resource
    resource.tweets
  end
end
