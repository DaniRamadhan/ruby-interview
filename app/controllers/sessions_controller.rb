class SessionsController < ApplicationController
  allow_unauthenticated_access only: :create

  def create
    user = User.authenticate_by(email: params[:email], password: params[:password])

    if user
      new_session = user.sessions.create!
      render json: { token: new_session.token, expires_at: new_session.expires_at }, status: :created
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def destroy
    current_session.destroy!
    head :no_content
  end
end
