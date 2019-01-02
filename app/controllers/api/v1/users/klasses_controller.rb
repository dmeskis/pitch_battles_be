class Api::V1::Users::KlassesController < ApplicationController
  before_action :key_present?, only: :create
  before_action :ready_create, only: :create
  before_action :prevent_duplicate, only: :create
  before_action :validate_user, only: :destroy

  def create
    if @klass.users << @user
      render json: {"success": "Successfully added #{@user.first_name} #{@user.last_name} to #{@klass.name}."}, status: 200
    else
      render json: {"error": "Unable to join #{@klass.name}. Please try again."}, status: 500
    end
  end

  def destroy
    if @klass.users.delete(@user)
      render json: {"success": "Successfully removed #{@user.first_name} #{@user.last_name} from #{@klass.name}."}
    else
      render json: {"error": "Unable to delete #{@user.first_name} #{@user.last_name} from #{@klass.name}."}
    end
  end

  private

  def klass_params
    params.permit(:class_key, :id, :klass_id)
  end

  def key_present?
    unless klass_params[:class_key]
      render json: {"error": "You must supply a class key to join a class"}
    end
  end

  def ready_create
    @user = User.where(id: klass_params[:id]).first
    @klass = Klass.find_by(class_key: klass_params[:class_key])
    unless @user && @klass
      render json: {"error": "Class not found."}, status: 404
    end
  end

  def validate_user
    @user = User.where(id: klass_params[:id]).first
    @klass = Klass.where(id: klass_params[:klass_id]).first
    unless @current_user == @user || @current_user.teacher? && @klass.teacher == @current_user
      render json: {"error": "Insufficient permissions to remove user from #{@klass.name}."}, status: 403
    end
  end

  def prevent_duplicate
    if @klass.users.include? @user
      render json: {"error": "Unable to join #{@klass.name}. You have already joined the class."}, status: 400
    end
  end

end