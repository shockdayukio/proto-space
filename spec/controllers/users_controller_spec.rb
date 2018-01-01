require 'rails_helper'
include ActionDispatch::TestProcess

describe UsersController do
  let(:password){Faker::Internet.password(8, 16, true, true)}
  let(:user){ create(:user, password: password) }
  let(:additional_prototype_num){ 3 }
  let(:prototypes){user.prototypes}
  let(:user_name){Faker::HarryPotter.character}
  let(:params){{ id: user.id, user: attributes_for(:user, name: user_name, password: password )}}
  let(:invalid_params){{ id: user.id, user: attributes_for(:user, name: user_name, password: nil )}}

  describe 'with an user login' do
    before :each do
      login_user(user)
    end

    context 'GET #show' do
      before :each do
        get :show, params: { id: user.id }
      end

      it "assigns the requested user to @user" do
        expect(assigns(:user)).to eq user
      end

      it "assigns the user's prototypes to prototype" do
        expect(assigns(:prototypes)).to eq prototypes
      end

      it "assigns the number of the user's prototypes to @prototypes_count" do
        expect(assigns(:prototypes_count)).to eq additional_prototype_num
      end
    end

    context 'GET #edit' do
      before :each do
        get :edit, params: { id: user.id }
      end

      it "assigns the requested user to @user" do
        expect(assigns(:user)).to eq user
      end
    end

    context 'PATCH #update' do
      context "when @user can be saved" do
        before :each do
          patch :update, params: params
        end

        it "assigns the requested user to @user" do
          expect(assigns(:user)).to eq user
        end

        it "changes @user's attributes" do
          user.reload
          expect(user.name).to eq user_name
        end

        it "redirect to prototypes path" do
          expect(response).to redirect_to prototypes_path
        end

        it "adds flash message" do
          expect(flash[:notice]).to eq "Succeeded to update your information"
        end
      end

      context "when @user can't be saved" do
        before :each do
          patch :update, params: invalid_params
        end

        it "assigns the requested user to @user" do
          expect(assigns(:user)).to eq user
        end

        it "redirect to :edit template" do
          expect(response).to redirect_to edit_user_path
        end

        it "adds flash message" do
          expect(flash[:alert]).to eq "Failed to update your information"
        end
      end
    end
  end

  describe "with an user doesn't login" do
    context 'GET #show' do
      before :each do
        get :show, params: { id: user.id }
      end

      it "assigns the requested user to @user" do
        expect(assigns(:user)).to eq user
      end

      it "renders :show template" do
        expect(response).to render_template :show
      end
    end

    context 'GET #edit' do
      it "redirect to login page" do
        get :edit, params: { id: user.id }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'PATCH #update' do
      it 'redirect to login page' do
        patch :update, params: {id: user.id}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end

