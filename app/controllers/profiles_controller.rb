class ProfilesController < ApplicationController
  before_action :set_profile

  def show
    @followings = @profile.user.followings_as_followee.includes(follower: :profile).order(:id)
  end

  def edit
  end

  def update
    respond_to do |format|
      if update_successs?
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_profile
    @profile ||= current_user.profile
  end

  def profile_params
    params.expect(profile: [ :username, :display_name, :avatar ])
  end

  def update_successs?
    Profile.transaction do
      @profile.avatar.purge if params[:remove_avatar] == "true"
      @profile.update!(profile_params)
    end
  end
end
