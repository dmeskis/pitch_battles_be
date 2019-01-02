class Api::V1::ClassDashboardController < ApplicationController

  def show
    @klass = @current_user.klass
    render json: ClassDashboardSerializer.new(@klass).serialized_json
  end

end