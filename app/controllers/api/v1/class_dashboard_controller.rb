class Api::V1::ClassDashboardController < ApplicationController
  before_action :user_has_class?, only: :show

  def show
    render json: ClassDashboardSerializer.new(@current_user.klass).serialized_json
  end

  private

  def user_has_class?
    unless @current_user.klass
      render json: {error: "No class associated with user."}, status: 404
    end
  end
end