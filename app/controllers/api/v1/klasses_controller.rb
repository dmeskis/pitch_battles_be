class Api::V1::KlassesController < ApplicationController
  before_action :validate_name_present, only: :create
  
  def create
    if @current_user && @current_user.role == 1
      klass = Klass.create(klass_params)
      @current_user.klasses << klass
      render json: KlassSerializer.new(klass).serialized_json, status: 200
    else
      render json: {"error": "You must be a teacher to create a class"}, status: 401
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