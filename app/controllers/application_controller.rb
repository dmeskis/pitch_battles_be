class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user
  
  include ExceptionHandler

  private

  def set_user
    @user = User.where(id: params[:id]).first
  end

  def is_teacher?
    unless @current_user.teacher?
      render json: {"error": "Teacher privileges required."}, status: 401
    end
  end

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

end
