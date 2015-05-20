class UserMailer < ActionMailer::Base
  default from: "no-reply@home-away.herokuapp.com"

  def welcome_email(email_data)
    email_address = email_data["email_address"]
    @user_name = email_data["user_name"]
    @id = email_data["id"]
    mail(to: email_address,
    subject: 'Welcome to HomeAway!')
  end
end
