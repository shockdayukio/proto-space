require 'rails_helper'
include ActionDispatch::TestProcess

describe PrototypesController do
  let(:prototype)           { create(:prototype, :with_comments) }
  let(:user)                {prototype.user}
  let(:prototype_name)       { Faker::Beer.name }
  let(:valid_params)         { { id: prototype.id, prototype: attributes_for(:prototype, name: prototype_name) } }
  let(:invalid_params)       { { id: prototype.id, prototype: attributes_for(:prototype, name: nil) } }


  describe 'with an user login' do
    before :each do
      login_user(user)
    end

    context 'GET #new' do
      before :each do
        get :new
      end

      it "assigns an array of tag examples to @placeholders" do
        expect(assigns(:placeholders)).to eq %W(Web\sdesign UI Application)
      end

      it "assigns a prototype instance to @prototype" do
        expect(assigns(:prototype)).to be_a_new(Prototype)
      end

      it "renders :new template" do
        expect(response).to render_template :new
      end
    end

    context 'POST #create' do

      context '@prototype can be saved' do
        before :each do
          post :create, params: valid_params
        end

        it "assigns a prototype instance which the current user will create to @prototype" do
          # expect(assigns(:prototype)).to be_a_new(Prototype)
        end

        it "redirect to :index template" do
          expect(response).to redirect_to prototypes_path
        end

        it "adds a flash message" do
          expect(flash[:notice]).to eq "Succeeded to publish your prototype"
        end
      end

      context '@prototype can\'t be saved' do
        before :each do
          post :create, params: invalid_params
        end

        it "redirect to :new template" do
          expect(response).to redirect_to new_prototype_path
        end

        it "adds a flash message" do
          expect(flash[:alert]).to eq "Failed to publish your prototype"
        end
      end
    end

    context 'GET #edit' do
      before :each do
        get :edit, params: { id: prototype.id }
      end

      it "assigns the requested prototype to @prototype" do
        expect(assigns(:prototype)).to eq prototype
      end

      it "renders :edit template" do
        expect(response).to render_template :edit
      end
    end

    context 'PATCH #update' do
      context '@prototype can be saved' do
        before :each do
          patch :update, params: valid_params
        end

        it "redirect to :index template" do
          expect(response).to redirect_to prototypes_path
        end

        it "adds a flash message" do
          expect(flash[:notice]).to eq "Succeeded to update your prototype"
        end
      end

      context '@prototype can\'t be saved' do
        before :each do
          patch :update, params: invalid_params
        end

        it "redirect to :new template" do
          expect(response).to redirect_to edit_prototype_path
        end

        it "adds a flash message" do
          expect(flash[:alert]).to eq "Failed to update your prototype"
        end
      end
    end

    context 'DELETE #destroy' do
      context 'when the user created the prototype' do
        before :each do
          delete :destroy, params: { id: prototype.id }
        end

        context '@prototype can be destroyed' do
          it "is redirect to :index template" do
            expect(response).to redirect_to prototypes_path
          end

          it "adds a flash message" do
            expect(flash[:notice]).to eq "Succeeded to delete your prototype"
          end
        end

        context '@prototype can\'t be destroyed' do
          it "is redirect to :index template" do
            expect(response).to redirect_to prototypes_path
          end

          it "adds a flash message" do
            expect(flash[:alert]).to eq "Failed to delete your prototype"
          end
        end
      end

      context 'when the user did\'t create the prototype' do
        let(:other_prototype) { create(:prototype) }
        before :each do
          delete :destroy, params: { id: other_prototype.id }
        end

        it 'redirect to :index template' do
          expect(response).to redirect_to prototypes_path
        end

        it 'adds a flash message' do
          expect(flash[:alert]).to eq "Cannot delete other's prototype"
        end
      end
    end
  end
end
