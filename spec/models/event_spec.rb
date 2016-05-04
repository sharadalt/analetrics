require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:name) {RandomData.random_sentence }
  
  let(:name) {RandomData.random_sentence }
  let(:url) {RandomData.random_sentence }
  
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld", confirmed_at: Time.zone.now) }
  let(:registered_application) { RegisteredApplication.create!(name: name, url: url, user: user) }
  let(:event) { registered_application.events.create!(name: name) }
 
  
  it { is_expected.to belong_to(:registered_application) }
  
  describe "attributes" do
    it "has a name attribute" do
      expect(event).to have_attributes(name: name)
    end
  end
  
end
