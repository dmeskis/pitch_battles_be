class Api::V1::Users::KlassesController < ApplicationController
  
  def create
    user = User.where(id: klass_params[:id]).first
    klass = Klass.find_by(class_key: klass_params[:class_key])
    if user && klass
      if klass.users << user
        render json: {"success": "Successfully added #{user.first_name} #{user.last_name} to #{klass.name}."}, status: 200
      end
    else
      render json: {"error": "Incorrect credentials."}, status: 404
    end
  end

  private

  def klass_params
    params.permit(:class_key, :id)
  end
end