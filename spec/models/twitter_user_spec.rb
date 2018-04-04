require 'rails_helper'

describe TwitterUser, type: :model do

  before(:each) do
    @user = create(:user)
    @twitter_user = create(:twitter_user)
  end

  it { expect(@user).to be_valid }
  it { expect(@twitter_user).to be_valid }

  it { should belong_to(:user) }
  it { should have_many(:tweets) }

  describe 'name should be improved before validation' do
    before(:each) do
      @invalid_name = TwitterUser.create(name: 'misha12@#$%$', owner: 'VasulykM',
                                         user_id: @user.id, followers: 2, following: 2)
    end
    it 'name should be capitalized' do
      @invalid_name.make_name_correct
      expect(@invalid_name.name).to eq('Misha12')
    end
  end

  describe 'when create set default value' do
    it 'set uid to 0' do
      expect(@twitter_user.uid).to eq(0)
    end
  end

  describe 'checks if owner exists in database' do
    before(:each) do
      @twitter_user2 = build(:twitter_user, owner: @twitter_user.owner)
    end
    it 'will raise error' do
      expect(@twitter_user2.owner).to eq(@twitter_user.owner)
      expect(@twitter_user2).not_to be_valid
    end
  end
end
