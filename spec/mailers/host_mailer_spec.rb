require "rails_helper"

RSpec.describe HostMailer, :type => :mailer do
  let(:traveler) { create(:user, name: "Test Name") }
  let(:host) { create(:host, name: "Test Name") }
  let(:property) { create(:property, user: host) }
  let(:reservation) { create(:reservation, user: traveler, property: property) }

  it "can notify a host that a guest would like to reserve a property" do
    data = reservation.email_data
    HostMailer.reservation_request(data).deliver
    result = ActionMailer::Base.deliveries.last

    expect(result).not_to be_nil
    expect(result.to).to include host.email_address
    expect(result.from).to include "no-reply@home-away.herokuapp.com"
    expect(result.subject).to eq "Someone Wants to Stay At Your Place!"
    expect(result.body).to include host.name
    expect(result.body).to include traveler.name
    expect(result.body).to include property.title
    expect(result.body).to include reservation.pretty_start_date
    expect(result.body).to include reservation.pretty_end_date
  end

  it "can notify a host that a guest has cancelled a pending reservation" do
    data = reservation.email_data
    HostMailer.cancellation_email(data).deliver
    result = ActionMailer::Base.deliveries.last

    expect(result).not_to be_nil
    expect(result.to).to include host.email_address
    expect(result.from).to include "no-reply@home-away.herokuapp.com"
    expect(result.subject).to eq "Reservation Cancellation"
    expect(result.body).to include host.name
    expect(result.body).to include traveler.name
    expect(result.body).to include property.title
  end
end
