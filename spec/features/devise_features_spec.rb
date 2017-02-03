require 'rails_helper'

RSpec.feature Devise, type: :feature do
  let(:user) do
    FactoryGirl.create(:user)
  end

  describe "Sign in" do
    scenario 'user cannot sign in if not registered' do
      signin('test@example.com', 'please123')
      expect(page).to have_content I18n.t('devise.failure.not_found_in_database', authentication_keys: I18n.t("activerecord.attributes.email"))
    end

    scenario 'user can sign in with valid credentials' do
      signin(user.email, user.password)
      expect(page).to have_content I18n.t('devise.sessions.signed_in')
    end

    scenario 'user cannot sign in with wrong email' do
      signin('invalid@email.com', user.password)
      expect(page).to have_content I18n.t('devise.failure.not_found_in_database', authentication_keys: I18n.t("activerecord.attributes.email"))
    end

    scenario 'user cannot sign in with wrong password' do
      signin(user.email, 'invalidpass')
      expect(page).to have_content I18n.t('devise.failure.invalid', authentication_keys: I18n.t("activerecord.attributes.email"))
    end
  end

  describe "Sign up" do
    let(:user) do
      FactoryGirl.build(:user)
    end

    scenario "visitor can signup with valid credentials" do
      sign_up_with(user.email, user.password, user.password, user.first_name, user.last_name)
      expect(page).to have_content(I18n.t("devise.registrations.signed_up_but_unconfirmed"))
    end

    scenario "visitor cannot signup with invalid credential" do
      sign_up_with(user.email, user.password, 'mismatch', user.first_name, user.last_name)
      expect(page).to have_content(I18n.t("simple_form.error_notification.default_message"))
    end

    scenario "visitor cannot signup with already taken email" do
      u = FactoryGirl.create(:user)
      sign_up_with(u.email, user.password, user.password, user.first_name, user.last_name)
      expect(page).to have_content(I18n.t("simple_form.error_notification.default_message"))
    end
  end

  describe "Sign out" do
    before do
      sign_in(user, scope: :user)
    end

    scenario "user signs out successfully" do
      visit root_path
      click_link I18n.t("devise.sessions.sign_out")
      expect(page).to have_content I18n.t("devise.sessions.signed_out")
    end
  end

  describe "Edit profile" do
    before do
      sign_in(user, scope: :user)
    end

    scenario "user changes email address" do
      visit edit_user_registration_path
      fill_in 'user_email', with: 'newemail@example.com'
      fill_in 'user_current_password', with: user.password
      click_button I18n.t("devise.registrations.edit.update")
      expect(page).to have_content(I18n.t("devise.registrations.update_needs_confirmation"))
    end

    scenario "user cannot edit another user's profile" do
      other = FactoryGirl.create(:user, email: 'other@example.com')
      visit edit_user_registration_path(other)
      expect(page).to have_field('user_email', with: user.email)
    end
  end

  describe "Destroy profile" do
    before do
      sign_in(user, scope: :user)
    end

    scenario "user can delete own account", js: true do
      visit edit_user_registration_path
      click_link I18n.t("devise.registrations.edit.cancel_my_account")
      a = page.driver.browser.switch_to.alert
      expect(a.text).to eq(I18n.t("devise.registrations.edit.are_you_sure"))
      a.accept
      expect(page).to have_content I18n.t("devise.registrations.destroyed")
    end
  end
end
