class  OmniauthLoginsController < ApplicationController
  def destroy
    respond_to do |format|
      if current_user.omniauth_logins.count <= 1 && !current_user.email.present?
        flash[:alert] = "You can't remove your only login method."
        format.html { redirect_to profile_path }
      else
        @omniauth_login = current_user.omniauth_logins.find(params[:id])
        @omniauth_login.destroy
        flash[:notice] = "Successfully removed #{@omniauth_login.provider} login."
        format.html { redirect_to profile_path }
      end
    end
  end
end
