class ProfilesController < ApplicationController
  before_action :set_profile, only: [ :show, :edit, :update ]

  def show
    @followings = @profile.user.followings_as_followee.includes(follower: :profile).order(:id)
  end

  def new
    redirect_to profile_path if current_user.profile.present?
    @profile ||= current_user.build_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)

    respond_to do |format|
      if @profile.save!
        format.html { redirect_to root_path, notice: "Profile was successfully created." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
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
