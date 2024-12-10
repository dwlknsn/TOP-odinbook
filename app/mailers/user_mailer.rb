class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_registration.subject
  #
  default from: "notifications@example.com"

  def new_registration
    @user = params[:user]
    mail(to: @user.email, subject: "Welcome to Odinbook")
  end
end
