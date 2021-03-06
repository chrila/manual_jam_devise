# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :authorize_admin, only: [:admin, :toggle_admin]

  # GET /users/admin
  def admin
    @users = User.all
  end

  # DELETE /users/1
  def destroy
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @user.destroy
      respond_to do |format|
        format.html { redirect_to user_admin_path, notice: 'User was successfully destroyed.' }
      end
    else
      super
    end
  end

  def toggle_admin
    @user = User.find(params[:user_id])
    @user.admin = !@user.admin
    @user.save
    respond_to do |format|
      format.html { redirect_to user_admin_path }
    end
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #  super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :admin])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :admin])
  end

  def authorize_admin
    unless signed_in? && current_user.admin?
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'Access denied.' }
      end
    end
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
