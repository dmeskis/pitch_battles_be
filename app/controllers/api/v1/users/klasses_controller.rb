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

  def destroy
    user = User.where(id: klass_params[:id]).first
    klass = Klass.where(id: klass_params[:klass_id]).first
    if klass.users.delete(user)
      render json: {"success": "Successfully removed #{user.first_name} #{user.last_name} from #{klass.name}."}
    else
      render json: {"error": "Unable to delete #{user.first_name} #{user.last_name} from #{klass.name}."}
    end
  end

  private

  def klass_params
    params.permit(:class_key, :id, :klass_id)
  end
end