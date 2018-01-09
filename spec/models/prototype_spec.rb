require 'rails_helper'
include ActionDispatch::TestProcess

describe Prototype do
  describe 'association' do
    context 'with a user' do
      let(:user){ create(:user) }
      let!(:prototype){ create(:prototype) }
      it 'is associated with an user' do
        prototype.user = user
        expect(prototype.user).to eq user
      end
    end

    context 'with main image' do
      let(:additional_main_image_num) { Prototype::NUMBER_OF_MAIN_IMAGE_IN_PROTOTYPE }
      let!(:prototype) { create(:prototype, :with_main_image, default_main_image_num: additional_main_image_num) }
      it 'deleted the main images when a prototype gets deleted' do
        total_main_image_num = additional_main_image_num * 2
        expect{prototype.destroy}.to change{ CapturedImage.count }.by(-1 * additional_main_image_num)
      end
    end

    context 'with sub images' do
      let(:additional_sub_images_num) { Prototype::MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE }
      let!(:prototype) { create(:prototype, :with_sub_images, default_sub_images_num: additional_sub_images_num) }
      it 'deleted the sub images when a prototype gets deleted' do
        total_sub_images_num = additional_sub_images_num * 2
        expect{ prototype.destroy }.to change{ CapturedImage.count }.by(-1 * total_sub_images_num)
      end
    end

    context 'with likes' do
      let(:additional_likes_num) { 5 }
      let!(:prototype) { create(:prototype, :with_likes, default_likes_num: additional_likes_num) }
      it 'deleted the likes when a prototype gets deleted' do
        total_likes_num = additional_likes_num * 2
        expect{ prototype.destroy }.to change{ Like.count }.by(-1 * total_likes_num)
      end
    end

    context 'with comments' do
      let(:additional_comments_num) { 5 }
      let!(:prototype) { create(:prototype, :with_comments, default_comments_num: additional_comments_num) }
      it 'deleted the comments when a prototype gets deleted' do
        total_comments_num = additional_comments_num * 2
        expect{prototype.destroy}.to change{ Comment.count }.by(-1 * total_comments_num)
      end
    end
  end

  describe 'validation' do
    let(:prototype){ build(:prototype) }

    context 'with all necessary attributes' do
      it 'is valid' do
        expect(prototype).to be_valid
      end
    end

    context 'without necessary attributes' do
      it 'is invalid without a name' do
        prototype.name = nil
        prototype.valid?
        expect(prototype.errors[:name]).to include('can\'t be blank')
      end

      it 'is invalid without a catch_copy' do
        prototype.catch_copy = nil
        prototype.valid?
        expect(prototype.errors[:catch_copy]).to include('can\'t be blank')
      end

      it 'is invalid without a concept' do
        prototype.concept = nil
        prototype.valid?
        expect(prototype.errors[:concept]).to include('can\'t be blank')
      end
    end

    context 'custom methods' do
      context 'no_more_than_three_tags method' do
        context "when a prototype contains no more than three tags" do
          let(:number_of_tags) { Prototype::NUMBER_OF_TAGS_IN_A_PROTOTYPE }
          it "is valid" do
            number_of_tags.times do
              prototype.tag_list.add("#{Faker::Beer.name}")
            end
            prototype.valid?
            expect(prototype).to be_valid
          end
        end

        context "when a prototype contains more than three tags" do
          let(:number_of_tags) { Prototype::NUMBER_OF_TAGS_IN_A_PROTOTYPE * 2 }
          it "is invalid" do
            number_of_tags.times do
              prototype.tag_list.add("#{Faker::Beer.name}")
            end
            prototype.valid?
            expect(prototype.errors[:tags]).to include "cannot be contained more than #{Prototype::NUMBER_OF_TAGS_IN_A_PROTOTYPE}"
          end
        end
      end

      context 'no_more_than_six_sub_images' do
        context 'when a prototype contains no more than six sub images' do
          let(:additional_sub_images_num) { Prototype::MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE }
          # default_sub_images_num = Prototype::MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE = 6
          let!(:prototype) { build(:prototype, :with_sub_images, default_sub_images_num: additional_sub_images_num) }
          it "is valid" do
            prototype.valid?
            expect(prototype).to be_valid
          end
        end

        context 'when a prototype contains more than six sub images' do
          let(:additional_sub_images_num) { Prototype::MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE * 2 }
          #  Prototype::MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE * 2 = 12
          let!(:prototype) { build(:prototype, :with_sub_images, default_sub_images_num: additional_sub_images_num) }
          it "is invalid" do
            prototype.valid?
            expect(prototype.errors[:sub_images]).to include("cannot be contained more than #{Prototype::MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE}")
          end
        end
      end
    end
  end
end
