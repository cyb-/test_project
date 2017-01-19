require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  describe "routing" do
    it "routes to users#index" do
      expect(get: "/users").to route_to("users#index")
    end

    it "routes to users#show" do
      expect(get: "/users/1").to route_to("users#show", id: "1")
    end

    it "routes to users#new" do
      expect(get: "/users/new").to route_to("users#new")
    end

    it "routes to users#create" do
      expect(post: "/users").to route_to("users#create")
    end

    it "routes to users#edit" do
      expect(get: "/users/1/edit").to route_to("users#edit", id: "1")
    end

    it "routes to users#update via PATCH" do
      expect(patch: "/users/1").to route_to("users#update", id: "1")
    end

    it "routes to users#update via PUT" do
      expect(put: "/users/1").to route_to("users#update", id: "1")
    end

    it "routes to users#update_role via PATCH" do
      expect(patch: "/users/1/update_role").to route_to("users#update_role", id: "1")
    end

    it "routes to users#update_role via PUT" do
      expect(put: "/users/1/update_role").to route_to("users#update_role", id: "1")
    end

    it "routes to users#delete" do
      expect(delete: "/users/1").to route_to("users#destroy", id: "1")
    end
  end
end
