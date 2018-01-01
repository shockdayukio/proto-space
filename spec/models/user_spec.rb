require 'rails_helper'

describe 'User' do
  describe '#create' do
    it "is valid with necessary information" do
      user = create(:user)
      expect(user).to eq User.last
    end

    it "is invalid without an email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid with a email that has already been saved" do
      user = create(:user)
      second_user = build(:user, email: user.email)
      second_user.valid?
      expect(second_user.errors[:email]).to include("has already been taken")
    end

    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid without a name" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "is invalid with a name that has already been saved" do
      user = create(:user)
      second_user = build(:user, name: user.name)
      second_user.valid?
      expect(second_user.errors[:name]).to include("has already been taken")
    end

    it "is invalid without a profile" do
      user = build(:user, profile: nil)
      user.valid?
      expect(user.errors[:profile]).to include("can't be blank")
    end

    it "is invalid without a works" do
      user = build(:user, works: nil)
      user.valid?
      expect(user.errors[:works]).to include("can't be blank")
    end

    it "is invalid without an occupation" do
      user = build(:user, occupation: nil)
      user.valid?
      expect(user.errors[:occupation]).to include("can't be blank")
    end
  end
end
