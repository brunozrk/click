module ControllerMacros
  def login_user
    before(:each) do
      user = users(:user_logged_in)
      sign_in user
    end
  end
end
