require 'rails_helper'

RSpec.describe "User management", type: :feature do
  let(:user) do
    FactoryGirl.create(:user, email: Faker::Internet.email)
  end

  context "as an admin" do
    before do
      sign_in(FactoryGirl.create(:user, :admin), scope: :user)
    end

    describe "index users page" do
      scenario "display registered users" do
        user
        visit users_path
        expect(page).to have_content(user.name)
      end

      scenario "should have invite and update role buttons" do
        user
        visit users_path
        expect(page).to have_link(I18n.t("actions.invite_user"), href: new_user_path)
        expect(page).to have_css("a#link-role-modal-#{user.id}")
      end
      
      scenario "click on edit role link should open modal", js: true do
        user
        visit users_path
        click_link(id: "link-role-modal-#{user.id}")
        expect(page).to have_css("div#modal-role-#{user.id}")
      end
    end

    describe "show user page" do
      scenario "should have edit and destroy links" do
        visit user_path(user)
        expect(page).to have_link(I18n.t("actions.edit"), href: edit_user_path(user))
        expect(page).to have_link(I18n.t("actions.destroy"), href: user_path(user))
      end
    end

    describe "invite user page" do
      scenario "create new invitation with valid params" do
        visit new_user_path
        fill_in 'user_email', with: Faker::Internet.email
        fill_in 'user_first_name', with: Faker::Name.first_name
        fill_in 'user_last_name', with: Faker::Name.last_name
        click_button I18n.t("helpers.submit.create", model: I18n.t("activerecord.models.user"))
        expect(page).to have_content(I18n.t("flashes.created", model: I18n.t("activerecord.models.user")))
      end

      scenario "create new invitation with invalid params" do
        visit new_user_path
        fill_in 'user_email', with: Faker::Internet.email
        fill_in 'user_first_name', with: ""
        fill_in 'user_last_name', with: Faker::Name.last_name
        click_button I18n.t("helpers.submit.create", model: I18n.t("activerecord.models.user"))
        expect(page).to have_content(I18n.t("simple_form.error_notification.default_message"))
      end
    end

    describe "edit user page" do
      scenario "update with valid params" do
        visit edit_user_path(user)
        fill_in 'user_email', with: 'newemail@example.com'
        click_button I18n.t("helpers.submit.update", model: I18n.t("activerecord.models.user"))
        expect(page).to have_content(I18n.t("flashes.updated", model: I18n.t("activerecord.models.user")))
      end

      scenario "update with invalid params" do
        visit edit_user_path(user)
        fill_in 'user_email', with: ''
        click_button I18n.t("helpers.submit.update", model: I18n.t("activerecord.models.user"))
        expect(page).to have_content(I18n.t("simple_form.error_notification.default_message"))
      end
    end

    scenario "destroy user", js: true do
      visit user_path(user)
      click_link I18n.t("actions.destroy")
      a = page.driver.browser.switch_to.alert
      expect(a.text).to eq(I18n.t("devise.registrations.edit.are_you_sure"))
      a.accept
      expect(page).to have_content(I18n.t("flashes.destroyed", model: I18n.t("activerecord.models.user")))
    end
  end

  context "as a user" do
    before do
      FactoryGirl.create(:user) # created because first user is always an admin ;)
      sign_in(FactoryGirl.create(:user, email: Faker::Internet.email), scope: :user)
    end

    describe "index users page" do
      scenario "display registered users" do
        user
        visit users_path
        expect(page).to have_content(user.name)
      end

      scenario "should not have invite and update role buttons" do
        visit users_path
        expect(page).not_to have_link(I18n.t("actions.invite_user"), href: new_user_path)
        expect(page).not_to have_css("button#button-modal-#{user.id}")
      end
    end

    describe "show user page" do
      scenario "should not have edit and destroy links" do
        visit user_path(user)
        expect(page).not_to have_link(I18n.t("actions.edit"), href: edit_user_path(user))
        expect(page).not_to have_link(I18n.t("actions.destroy"), href: user_path(user))
      end
    end

    scenario "should not access to invite user page" do
      visit new_user_path
      expect(page).to have_content(I18n.t("unauthorized.create.user"))
    end

    scenario "should not access to edit user page" do
      visit edit_user_path(user)
      expect(page).to have_content(I18n.t("unauthorized.update.user"))
    end
  end

  context "as a visitor" do
    scenario "should not access to index users page" do
      visit users_path
      expect(page).to have_content(I18n.t("unauthorized.read.user"))
    end

    scenario "should not access to show user page" do
      visit user_path(user)
      expect(page).to have_content(I18n.t("unauthorized.read.user"))
    end

    scenario "should not access to edit user page" do
      visit edit_user_path(user)
      expect(page).to have_content(I18n.t("unauthorized.update.user"))
    end
  end
end
