class Api::V1::TeacherDashboardController < ApplicationController
  before_action :is_teacher?

  def index
    @klasses = Klass.where(teacher_id: @current_user.id)
    if @klasses.present?
      render json: KlassSerializer.new(@klasses).serialized_json, status: 200
    else
      render json: {error: "No classes found."}
    end
  end

  def show
    @klass = Klass.find_by(id: params[:id])
    if @klass != nil
      render json: TeacherDashboardSerializer.new(@klass).serialized_json
    else
      render json: {error: "Class not found." }, status: 404
    end
  end

  private

  def is_teacher?
    unless @current_user.teacher?
      render json: {"error": "You must be a teacher to create a class"}, status: 401
    end
  end

  def is_teacher_of_class?(klass)
    unless klass.teacher == @current_user
      render json: {"error": "You must be the teacher of this class to view it"}, status: 401
    end
  end 

end