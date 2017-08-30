require 'rails_helper'

RSpec.describe Preference, type: :model do

  let!(:event) { Event.create(name: "dev magic", time: DateTime.now, duration: 5)}
  let!(:user) { User.create(name: "dev magic", email: "me@example.com")}
  let!(:timeslot) { Timeslot.create(start_time: DateTime.now, event_id: 1)}
  
  subject {
    described_class.new(preference_type: 3, timeslot_id: 1, user_id: 1)
  }

  it "is valid with atrributes" do
    expect(subject).to be_valid
  end

  it "is invalid without a preference type" do
    subject.preference_type = nil
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it "belongs to user" do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it "belongs to timeslot" do
      assc = described_class.reflect_on_association(:timeslot)
      expect(assc.macro).to eq :belongs_to
    end
  end

end