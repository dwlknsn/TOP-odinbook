class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!

  def after_sign_in_path_for(user)
    if user.profile.nil?
      new_profile_path
    else
      profile_path
    end
  end
end
