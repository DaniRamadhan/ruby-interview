class ApplicationController < ActionController::API
  include Authentication

  rescue_from ActiveRecord::RecordInvalid do |error|
    render json: { error: error.record.errors.full_messages }, status: :unprocessable_content
  end

  rescue_from ActiveRecord::RecordNotFound do |error|
    render json: { error: error.message }, status: :not_found
  end
end
