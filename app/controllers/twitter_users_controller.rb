class TwitterUsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @twitter_users = TwitterUser::Index.call(current_user: current_user)['model']
  end

  def show
    result = TwitterUser::Show.call(params: params.permit(:id), current_user: current_user)
    @twitter_user = result['user']
    @tweets = result['tweets']
  end

  def new
    @twitter_user = TwitterUser::New.call(current_user: current_user)['model']
  end

  def create
    binding.pry
    result = TwitterUser::Create.call(params: user_params, current_user: current_user)
    if result.success?
      redirect_to twitter_users_path, flash: { success: 'New user is successfuly added!' }
    else
      redirect_to new_twitter_user_path, flash: { danger: 'Your new user has invalid data!'}
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
