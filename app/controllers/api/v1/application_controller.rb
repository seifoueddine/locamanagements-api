module Api
    module V1
      class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
        before_action :authenticate_user!
        before_action :configure_permitted_parameters, if: :devise_controller?
        protect_from_forgery with: :null_session


        def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_in) do |user_params|
            user_params.permit(:email, :password)
          end
        end



      end
    end
  end