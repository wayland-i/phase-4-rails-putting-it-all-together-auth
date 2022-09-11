class ApplicationController < ActionController::API
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_error

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error

  before_action :authorize


  private

  def authorize
    @current_user = User.find_by(id: session[:user_id])

    render json: { errors: ["Not authorized"] }, status: :unauthorized unless @current_user
  end

  def render_unprocessable_entity_error(invalid)
    render json: {errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_not_found_error(not_found)
		render json: { error: "#{not_found.model} not found"}, status: :not_found
	end

end
