require 'rails_helper'

describe User, type: :model do

  let!(:user) { User.new(name: 'misha', email: 'misha@mail.com', password: '123456') }

  it { expect(user).to be_valid }
  it { should have_many(:twitter_users) }

  it 'name should be capitalized' do
    expect(user.capitalize_name).to eq('Misha')
  end

  describe 'name field validation' do
    invalid_user = User.new(name: 'mishad323', email: 'mishamaim', password: '123')
    it 'name should be only letters' do
      expect(invalid_user.name).not_to eq(User::VALID_NAME_REGEX)
      expect(invalid_user.email).not_to eq(User::VALID_EMAIL_REGEX)
      expect(invalid_user.password.length).not_to be(6)
    end
    it { expect(invalid_user).not_to be_valid }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  it 'sends an email' do
    user.save
    expect{ user.send_email }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

end