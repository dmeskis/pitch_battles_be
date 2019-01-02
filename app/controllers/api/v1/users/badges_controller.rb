class Api::V1::Users::BadgesController < ApplicationController
  before_action :set_user

  def index
    if @user
      render json: UserBadgesSerializer.new(@user).serialized_json, status: 200
    else
      render json: {"error": "User not found."}, status: 404
    end
  end

end