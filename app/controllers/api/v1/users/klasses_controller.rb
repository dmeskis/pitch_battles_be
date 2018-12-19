class Api::V1::Users::KlassesController < ApplicationController
  
  def create
    user = User.where(id: klass_params[:id])
    klass = Klass.find_by(class_key: klass_params[:class_key])
    binding.pry
  end

  private

  def klass_params
    params.permit(:class_key, :id)
  end
end