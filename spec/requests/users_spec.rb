require 'rails_helper'
describe 'UsersController' do
  let(:user){ create(:user) }

  describe 'GET #show' do
    describe "when an user doesn't log in"do
      it "renders the :new template in devise/registration/" do
        get :show, id: user
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
