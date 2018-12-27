class Api::V1::KlassesController < ApplicationController
  before_action :set_variables, only: :destroy
  before_action :set_create_variables, only: :create
  before_action :is_teacher?, only: :create
  before_action :is_class_teacher?, only: :destroy
  before_action :validate_name_present, only: :create
  
  def create
    if @klass.save
      render json: KlassSerializer.new(@klass).serialized_json, status: 200
    else
      render json: {"error": "Unable to save class, please try again."}, status: 500
    end
  end

  def destroy
    if @klass.delete
      render json: {"success": "Successfully deleted #{@klass.name}."}
    else
      render json: {"error": "Unable to delete #{@klass.name}, please try again."}
    end
  end

  private

  def klass_params
    params.permit(:name)
  end

  def set_variables
    @klass = Klass.where(id: params[:id]).first
  end

  def set_create_variables
    @klass = Klass.new(klass_params)
    @klass.teacher_id = @current_user.id
  end

  def is_teacher?
    unless @current_user.teacher?
      render json: {"error": "You must be a teacher to create a class"}, status: 401
    end
  end

  def is_class_teacher?
    unless @klass.teacher == @current_user
      render json: {"error": "You must be a teacher of a class to delete it."}, status: 401
    end
  end

  def validate_name_present
    unless klass_params["name"]
      render json: {"error": "You must enter a class name."}, status: 422
    end
  end

end