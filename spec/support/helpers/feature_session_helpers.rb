module Features
  module SessionHelpers
    def sign_up_with(email, password, confirmation, first_name, last_name)
      visit new_user_registration_path
      fill_in 'user_email', with: email
      fill_in 'user_first_name', with: first_name
      fill_in 'user_last_name', with: last_name
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: confirmation
      click_button I18n.t("devise.registrations.new.sign_up")
    end

    def signin(email, password)
      visit new_user_session_path
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      click_button I18n.t("devise.sessions.new.sign_in")
    end
  end
end
