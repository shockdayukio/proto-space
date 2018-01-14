require 'rails_helper'
include ActionDispatch::TestProcess

describe Prototype do
  describe 'validation' do
    let(:prototype){ build(:prototype) }

    context 'with all necessary attributes' do
      it 'is valid' do
        expect(prototype).to be_valid
      end
    end

    context 'without necessary attributes' do
      context 'name' do
        it 'is invalid when a name is nil' do
          prototype.name = nil
          prototype.valid?
          expect(prototype.errors[:name]).to include('can\'t be blank')
        end

        it 'is invalid when a name has no content' do
          prototype.name = ""
          prototype.valid?
          expect(prototype.errors[:name]).to include('can\'t be blank')
        end
      end


      context 'catch_copy' do
        it 'is invalid when a catch_copy is nil' do
          prototype.catch_copy = nil
          prototype.valid?
          expect(prototype.errors[:catch_copy]).to include('can\'t be blank')
        end

        it 'is invalid when a catch_copy has no content' do
          prototype.catch_copy = ""
          prototype.valid?
          expect(prototype.errors[:catch_copy]).to include('can\'t be blank')
        end
      end

      context 'concept' do
        it 'is invalid when a concept is nill' do
          prototype.concept = nil
          prototype.valid?
          expect(prototype.errors[:concept]).to include('can\'t be blank')
        end

        it 'is invalid when a concept has no content' do
          prototype.concept = ""
          prototype.valid?
          expect(prototype.errors[:concept]).to include('can\'t be blank')
        end
      end
    end

    context 'custom validations' do
      context 'no_more_than_three_tags method' do
        let(:number_of_tags) { Prototype::NUMBER_OF_TAGS_IN_A_PROTOTYPE }
        context "when a prototype contains three or less tags" do
          it "is valid" do
            number_of_tags.times do
              prototype.tag_list.add("#{Faker::Beer.name}")
            end
            prototype.valid?
            expect(prototype).to be_valid
          end
        end

        context "when a prototype contains more than four tags" do
          it "is invalid" do
            invalid_number_of_tags = number_of_tags * 2
            invalid_number_of_tags.times do
              prototype.tag_list.add("#{Faker::Beer.name}")
            end
            prototype.valid?
            expect(prototype.errors[:tags]).to include "cannot be contained more than #{Prototype::NUMBER_OF_TAGS_IN_A_PROTOTYPE}"
          end
        end
      end

      context 'no_more_than_six_sub_images method' do
        let(:prototype) { build(:prototype, :with_sub_images, default_sub_images_num: additional_sub_images_num) }
        context 'when a prototype contains no more than six sub images' do
          let(:additional_sub_images_num) { Prototype::MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE }
          it "is valid" do
            prototype.valid?
            expect(prototype).to be_valid
          end
        end

        context 'when a prototype contains more than six sub images' do
          let(:additional_sub_images_num) { Prototype::MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE * 2 }
          it "is invalid" do
            prototype.valid?
            expect(prototype.errors[:sub_images]).to include("cannot be contained more than #{Prototype::MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE}")
          end
        end
      end
    end

    context 'other instance methods' do
      let(:prototype_with_no_image) { create(:prototype) }
      let(:first_user) { prototype_with_no_image.user = create(:user)}
      let(:second_user) { create(:user) }

      context 'main_image method' do
        context 'with a main image' do
          let(:prototype_with_main_image){ create(:prototype, :with_main_image) }
          it "returns the main image" do
            expect(prototype_with_main_image.main_image).to eq prototype_with_main_image.captured_images.main.first.image
          end
        end

        context 'with no main image' do
          it "returns no-image.png" do
            expect(prototype_with_no_image.main_image).to eq "no-image.png"
          end
        end
      end

      context 'sub_images method' do
        it "returns sub image instances" do
          prototype_with_sub_images = create(:prototype, :with_sub_images)
          expect(prototype_with_sub_images.sub_images).to eq prototype_with_sub_images.captured_images.sub
        end
      end

      context 'created_by? method' do
        context "with an argument which is the prototype's user" do
          it "returned true" do
            expect(prototype_with_no_image.created_by?(first_user)).to be_truthy
          end
        end

        context "with an argument which is an other user" do
          it "returned false" do
            expect(prototype_with_no_image.created_by?(second_user)).to be_falsey
          end
        end
      end

      context 'liked_by? method' do
        context "with argument which is nil" do
          it "returns false when the argument is nil" do
            nil_obj = nil
            expect(prototype_with_no_image.liked_by?(nil_obj)).to be_falsey
          end
        end

        context "with an argument which is an user instance" do
          it "return false when the like has not been created by the given user" do
            expect(prototype_with_no_image.liked_by?(second_user)).to be_falsey
          end

          it "returns true when the like has been created by the given user" do
            like = create(:like, prototype_id: prototype_with_no_image.id, user_id: second_user.id)
            expect(prototype_with_no_image.liked_by?(second_user)).to be_truthy
          end
        end
      end

      context 'comment_num method' do
        it "returns the number of prototype's comments" do
          num_of_comments = prototype_with_no_image.comments.size
          expect(prototype_with_no_image.comment_num).to eq num_of_comments
        end
      end

      context 'create_at method' do
        it "returns the date that the prototype was created in the simple format" do
          Year_digit = 4
          Min_day_digit = 1
          Max_day_digit = 2
          time = Time.new(2018, 1, 1, 00, 00)
          prototype_created_now = create(:prototype, created_at: time)
          expect(prototype_created_now.created_at).to match(/\d{#{Year_digit}} [A-Z][a-z][a-z] \d{#{Min_day_digit},#{Max_day_digit}}/)
        end
      end
    end
  end
end
