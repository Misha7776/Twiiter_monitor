class UserMailer < ApplicationMailer
  def registration(user)
    @user = user
    mail to: user.email, subject: 'Your credentials'
  end
end
