class ApplicationController < ActionController::API

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    binding.pry
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    # header is present in black list or not
    token = BlacklistedToken.exists?(jti: header)
    if !token
      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    else
      render json: { errors: "Access Denied" }, status: :unauthorized
    end
  end
end