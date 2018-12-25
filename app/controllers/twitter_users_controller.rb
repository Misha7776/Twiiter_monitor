class TwitterUsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @twitter_users = TwitterUser::Index.call(current_user: current_user)['model']
  end

  def show
    result = TwitterUser::Show.call(params: params.permit(:id), current_user: current_user)
    @twitter_user = result[:model]
    @tweets = result[:tweets]
  end

  def new
    @twitter_user = TwitterUser::New.call(current_user: current_user)['model']
  end

  def create
    result = TwitterUser::Create.(params: params, current_user: current_user)
    if result.success?
      redirect_to twitter_users_path, flash: { success: 'New user is successfuly added!' }
    else
      redirect_to new_twitter_user_path, flash: { danger: 'Your new user has invalid data!'}
    end
  end

  def edit
    result = TwitterUser::Edit.call( params: params.permit(:id) )
    @twitter_user = result[:model]
  end

  def update
    result = TwitterUser::Update.call( params: params)
    @twitter_user = result[:model]
    if result.success?
      redirect_to @twitter_user, flash: { success: 'Profile updated' }
    else
      redirect_to edit_twitter_user_path, flash: { danger: "Profile can`t be updated, fill the fields" }
    end
  end

  def destroy
    TwitterUser::Destroy.call( params: params.permit(:id) )
    redirect_to twitter_users_path, flash: { success: 'User deleted' }
  end
end
