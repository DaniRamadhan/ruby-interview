module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate!
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :authenticate!, **options
    end
  end

  private

  def authenticate!
    @current_session = find_session_by_token
    return if @current_session

    render json: { error: "Unauthorized" }, status: :unauthorized
  end

  def find_session_by_token
    token = request.authorization.to_s.delete_prefix("Bearer ").strip
    return nil if token.blank?

    Session.active.find_by(token: token)
  end

  def current_session
    @current_session
  end

  def current_user
    @current_session&.user
  end
end
