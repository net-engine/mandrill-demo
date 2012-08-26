require 'spec_helper'

describe MessagesController do
  describe "GET 'index'" do
    context "as a guest" do
      it "should redirect to sign in" do
        get 'index'
        response.should redirect_to new_user_session_path
      end
    end

    context "signed in" do
      before :each do
        @user = FactoryGirl.create(:user)
        sign_in(:user, @user)
      end

      it "should be a success" do
        get 'index'
        response.should be_success
      end
    end
  end
end
