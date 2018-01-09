require 'rails_helper'
include ActionDispatch::TestProcess

describe User do
  let(:user){ build(:user) }

  describe 'validation' do
    context 'when a user is filled all valid attributes' do
      it "is valid" do
        expect(user).to be_valid
      end
    end

    context 'when a user lacks of one valid attributes' do

      context 'email' do
        it "is invalid with no content" do
          user.email = ""
          user.valid?
          expect(user.errors[:email]).to include("can't be blank")
        end
        it "is invalid with nil" do
          user.email = nil
          user.valid?
          expect(user.errors[:email]).to include("can't be blank")
        end
      end

      context "password" do
        it "is invalid with nil" do
          user.password = nil
          user.valid?
          expect(user.errors[:password]).to include("can't be blank")
        end
        context 'when checking the length of the password' do
          it "is valid if an user's password is within 6 to 128 characters" do
            user.password = Faker::Internet.password(6, 128, true, true)
            user.valid?
            expect(user).to be_valid
          end

          it "is valid if an user's password is less than 6 characters" do
            user.password = Faker::Internet.password(1, 5, true, true)
            user.valid?
            expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
          end

          it "is invalid if an user's password is has more than 129 characters" do
            user.password = Faker::Internet.password(129)
            user.valid?
            expect(user.errors[:password]).to include("is too long (maximum is 128 characters)")
          end
        end
      end

      context 'name' do
        it "is invalid with no content" do
          user.name = ""
          user.valid?
          expect(user.errors[:name]).to include("can't be blank")
        end
        it "is invalid with nil" do
          user.name = nil
          user.valid?
          expect(user.errors[:name]).to include("can't be blank")
        end
      end

      context 'profile' do
        it "is invalid with no content" do
          user.profile = ""
          user.valid?
          expect(user.errors[:profile]).to include("can't be blank")
        end
        it "is invalid with nil" do
          user.profile = nil
          user.valid?
          expect(user.errors[:profile]).to include("can't be blank")
        end
      end

      context "work" do
        it "is invalid with no content" do
          user.works = ""
          user.valid?
          expect(user.errors[:works]).to include("can't be blank")
        end
        it "is invalid with nil" do
          user.works = nil
          user.valid?
          expect(user.errors[:works]).to include("can't be blank")
        end
      end

      context "avatar" do
        it "invalid with no content" do
          user.avatar = ""
          user.valid?
          expect(user.errors[:avatar]).to include("can't be blank")
        end
        it "is invalid with nil" do
          user.avatar = nil
          user.valid?
          expect(user.errors[:avatar]).to include("can't be blank")
        end
      end

      context "occupation" do
        it "is invalid with no content" do
          user.occupation = ""
          user.valid?
          expect(user.errors[:occupation]).to include("can't be blank")
        end
        it "is invalid with nil" do
          user.occupation = nil
          user.valid?
          expect(user.errors[:occupation]).to include("can't be blank")
        end
      end
    end

    context 'when a user contains one of attributes that has already been saved' do
      let(:first_user){create(:user)}

      it "is invalid with a email that has already been saved" do
        second_user = build(:user, email: first_user.email)
        second_user.valid?
        expect(second_user.errors[:email]).to include("has already been taken")
      end

      it "is invalid with a name that has already been saved" do
        second_user = build(:user, name: first_user.name)
        second_user.valid?
        expect(second_user.errors[:name]).to include("has already been taken")
      end
    end
  end
end
