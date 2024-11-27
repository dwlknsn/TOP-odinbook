class ProfilesController < ApplicationController
  before_action :set_profile

  def show
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to @profile
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile ||= current_user.profile
  end

  def profile_params
    params.expect(profile: [ :username, :display_name, :avatar ])
  end
end
