require 'rails_helper'

RSpec.feature "Home page", type: :feature do
  context "as visitor" do
    scenario "should have link to sign in" do
      visit root_path
      expect(page).to have_link(I18n.t("devise.shared.links.sign_in"), href: new_user_session_path)
    end

    scenario "should have link to sign up" do
      visit root_path
      expect(page).to have_link(I18n.t("devise.shared.links.sign_up"), href: new_user_registration_path)
    end

    scenario "should not have link to sign out" do
      visit root_path
      expect(page).not_to have_link(I18n.t("devise.sessions.sign_out"), href: destroy_user_session_path)
    end

    scenario "should not have link to users list" do
      visit root_path
      expect(page).not_to have_link(I18n.t("activerecord.models.user").pluralize, href: users_path)
    end

    scenario "should not have link to edit registration user" do
      visit root_path
      expect(page).not_to have_link(I18n.t("devise.registrations.my_account"), href: edit_user_registration_path)
    end
  end

  context "as logged user" do
    before do
      sign_in(FactoryGirl.create(:user), scope: :user)
    end

    scenario "should have link to index users page" do
      visit root_path
      expect(page).to have_link(I18n.t("activerecord.models.user").pluralize, href: users_path)
    end

    scenario "should have link to edit registration page" do
      visit root_path
      expect(page).to have_link(I18n.t("devise.registrations.my_account"), href: edit_user_registration_path)
    end

    scenario "should have link to sign out" do
      visit root_path
      expect(page).to have_link(I18n.t("devise.sessions.sign_out"), href: destroy_user_session_path)
    end

    scenario "should not have link to sign in" do
      visit root_path
      expect(page).not_to have_link(I18n.t("devise.shared.links.sign_in"), href: new_user_session_path)
    end

    scenario "should not have link to sign up" do
      visit root_path
      expect(page).not_to have_link(I18n.t("devise.shared.links.sign_up"), href: new_user_registration_path)
    end
  end
end
