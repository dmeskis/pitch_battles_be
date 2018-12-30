class PasswordMailer < ApplicationMailer

  def password_reset_email
    @user = params[:user]
    @token = @user.reset_password_token
    mail(to: @user.email, subject: 'Pitch Battles - Password Reset')
  end
end
