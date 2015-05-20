class TravelerMailer < ActionMailer::Base
  default from: "no-reply@home-away.herokuapp.com"

  def request_received(email_data)
    email_address = email_data["traveler_email_address"]
    @traveler_name = email_data["traveler_name"]
    @property_name = email_data["property_name"]
    @start_date = email_data["start_date"]
    @end_date = email_data["end_date"]
    @total = email_data["total"]
    @price = email_data["price"]
    @id = email_data["id"]

    mail(to: email_address,
    subject: 'Reservation Request Received')
  end

  def confirmation_email(email_data)
    email_address = email_data["traveler_email_address"]
    @traveler_name = email_data["traveler_name"]
    @host_name = email_data["host_name"]
    @property_name = email_data["property_name"]
    @start_date = email_data["start_date"]
    @end_date = email_data["end_date"]
    @id = email_data["id"]

    mail(to: email_address,
    subject: 'Reservation Approved!')
  end

  def denial_email(email_data)
    email_address = email_data["traveler_email_address"]
    @traveler_name = email_data["traveler_name"]
    @property_name = email_data["property_name"]
    @start_date = email_data["start_date"]
    @end_date = email_data["end_date"]

    mail(to: email_address,
    subject: 'Reservation Declined')
  end
end
