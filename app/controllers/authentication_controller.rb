class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login


  def login
    #binding.pry
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M")}, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def logout
    binding.pry
    # exp_tokens
    jti = request.headers['Authorization']
    jti = jti.split(' ').last if jti
    BlacklistedToken.create!(
        jti: jti
      )
    render json: {response: "successfully logged out"}, status: :ok
  end


  private

  def login_params
    params.permit(:email, :password)
  end
end