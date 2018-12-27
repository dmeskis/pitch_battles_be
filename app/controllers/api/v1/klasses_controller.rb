class Api::V1::KlassesController < ApplicationController
  before_action :validate_name_present, only: :create
  
  def create
    if @current_user.teacher?
      klass = Klass.new(klass_params)
      klass.teacher_id = @current_user.id
      if klass.save
        render json: KlassSerializer.new(klass).serialized_json, status: 200
      else
        render json: {"error": "Unable to save class, please try again."}, status: 500
      end
    else
      render json: {"error": "You must be a teacher to create a class"}, status: 401
    end
  end

  def destroy
    klass = Klass.where(id: params[:id]).first
    if klass.teacher == @current_user
      klass.delete
      render json: {"success": "Successfully deleted #{klass.name}."}
    else
      render json: {"error": "Unable to delete class"}, status: 401
    end
  end

  private

  def klass_params
    params.permit(:name)
  end

  def validate_name_present
    unless klass_params["name"]
      render json: {"error": "You must enter a class name."}, status: 422
    end
  end

end