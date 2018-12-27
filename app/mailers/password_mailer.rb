class PasswordMailer < ApplicationMailer

  def password_reset_email
    @user = params[:user]
    @url = "ADD THIS LINK LATER"
    mail(to: @user.email, subject: 'Pitch Battles - Password Reset')
  end
end
