require 'rails_helper'

RSpec.describe Devise, type: :routing do
  describe "rooting" do
    it "routes to devise/invitations#edit" do
      expect(get: "/account/invitation/accept").to route_to("devise/invitations#edit")
    end

    it "routes to devise/invitations#update" do
      expect(patch: "/account/invitation").to route_to("devise/invitations#update")
      expect(put: "/account/invitation").to route_to("devise/invitations#update")
    end

    it "routes to registrations#cancel" do
      expect(get: "/account/cancel").to route_to("registrations#cancel")
    end

    it "routes to registrations#new" do
      expect(get: "/account/sign_up").to route_to("registrations#new")
    end

    it "routes to registrations#create" do
      expect(post: "/account").to route_to("registrations#create")
    end

    it "routes to registrations#edit" do
      expect(get: "/account/edit").to route_to("registrations#edit")
    end

    it "routes to registrations#update" do
      expect(patch: "/account").to route_to("registrations#update")
      expect(put: "/account").to route_to("registrations#update")
    end

    it "routes to registrations#destroy" do
      expect(delete: "/account").to route_to("registrations#destroy")
    end
  end
end
