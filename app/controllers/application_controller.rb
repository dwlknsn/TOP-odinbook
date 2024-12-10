class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!
  before_action :ensure_profile_exists, unless: :registration_controller?

  private

  def ensure_profile_exists
    return unless user_signed_in?
    return if current_user.profile.present?

    redirect_to new_profile_path
  end

  def after_sign_in_path_for(user)
    if user.profile.nil?
      new_profile_path
    else
      profile_path
    end
  end

  def registration_controller?
    [
      Devise::RegistrationsController,
      Users::OmniauthCallbacksController
    ].any? do |klass|
      self.is_a?(klass)
    end
  end
end
