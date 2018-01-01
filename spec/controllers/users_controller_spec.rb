require 'rails_helper'
describe 'UsersController'do
  let(:user){ create(:user) }

  describe 'GET #show' do
    describe "when an user doesn't log in", type: :request do
      it "renders the :new template in devise/registration/" do
        get :show, id: user.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    # describe 'when an user log in' do
    #   it "assigns the variables @prototype_count" do
    #   end

    #   it "assigns the variables @prototypes" do
    #   end

    #   it "renders the :new template in devise/registration/" do
    #     # get user_path
    #     # expect(last_response.status).to eq(200)
    #   end
    # end
  end

  # describe 'GET #edit' do
  #   describe  "when an user doesn't log in" do
  #     it "renders the :new template in devise/registration/" do
  #       # get user_edit_path
  #       # expect(last_response.status).to eq(200)
  #     end
  #   end

  #   describe 'when an user log in' do
  #     # before do
  #     #   sign_in user
  #     #   variables @user
  #     # end

  #     it "renders the :new template in devise/registration/" do
  #       # get user_path
  #       # expect(last_response.status).to eq(200)
  #     end
  #   end
  # end

  # describe 'POST #update' do
  #   describe  "when an user doesn't log in"  do
  #     it "renders the :new template in devise/registration/" do
  #       # patch user_path
  #       # expect(last_response.status).to eq(200)
  #     end
  #   end

  #   describe 'when an user log in' do
  #     it "assigns @user that is invalid" do
  #     end

  #     it "assigns @user that is valid" do
  #     end
  #   end
  # end
end
