# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)
    if current_user
      render json: {
        status: {
          code: 400, message: "Please, you must log out to create a new user."
        }
      }
    else
      if resource.save
        render json: {
          status: { code: 200, message: "Singed up successfully"
          }
        }
      else
        render json: {
          status: { message: 'User could not be created successfully', errors: resource.errors.full_messages}
        }, status: :unprocessable_entity
      end
    end
  end

  private

  def sign_up_params
      params.require(:user).permit(:email, :password, :name, :addres, :phone)
  end
end

