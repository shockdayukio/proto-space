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
  end
end
