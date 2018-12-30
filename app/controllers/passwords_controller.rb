class PasswordsController < ApplicationController
  skip_before_action :authenticate_request

  def forgot
    if params[:email].blank?
      return render json: {error: 'Email not present'}
    end

    user = User.find_by(email: params[:email])

    if user.present?
      user.generate_password_token!
      PasswordMailer.with(user: user).password_reset_email.deliver_now
      render json: {success: 'Please check your email to reset your password.'}, status: 200
    else
      render json: {error: 'Email address not found. Please check and try again.'}, status: 404
    end
  end

  def reset
    token = params[:token].to_s

    user = User.find_by(reset_password_token: token)

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: {success: "Password successfully reset!"}, status: 200
      else
        render json: {error: user.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {error:  ['Link not valid or expired. Try generating a new link.']}, status: :not_found
    end
  end
end