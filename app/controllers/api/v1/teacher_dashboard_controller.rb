class Api::V1::TeacherDashboardController < ApplicationController
  before_action :class_exists?, only: :show
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
    if is_teacher_of_class?(@klass)
      render json: TeacherDashboardSerializer.new(@klass).serialized_json
    else
      render json: {"error": "You must be the teacher of this class to view it"}, status: 401
    end
  end

  private

  def is_teacher?
    unless @current_user.teacher?
      render json: {"error": "You must be a teacher to create a class"}, status: 401
    end
  end

  def class_exists?
    @klass = Klass.find_by(id: params[:id])
    unless @klass
      render json: {"error": "Class not found"}, status: 404
    end
  end

  def is_teacher_of_class?(klass)
    klass.teacher == @current_user
  end 

end