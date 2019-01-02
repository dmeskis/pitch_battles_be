class Api::V1::TeacherDashboardController < ApplicationController
  before_action :is_teacher?

  def show
    @klass = Klass.find_by(teacher_id: @current_user.id)
    if @klass != nil
      render json: TeacherDashboardSerializer.new(@klass).serialized_json
    else
      render json: {error: "No classes found" }, status: 404
    end
  end

  private

  def is_teacher?
    unless @current_user.teacher?
      render json: {"error": "You must be a teacher to create a class"}, status: 401
    end
  end

end