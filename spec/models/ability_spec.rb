require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability, type: :model do
  context "as an admin" do
    subject(:ability) {
      Ability.new FactoryGirl.build(:user, :admin)
    }

    it "should be able to manage all" do
      expect(subject).to be_able_to(:manage, :all)
    end

    it "should be able to read users" do
      expect(subject).to be_able_to(:read, User)
    end

    it "should be able to edit users" do
      expect(subject).to be_able_to(:update, User)
    end

    it "should be able to update users role" do
      expect(subject).to be_able_to(:update_role, User)
    end

    it "should be able to destroy user" do
      expect(subject).to be_able_to(:destroy, User)
    end
  end

  context "as a user" do
    subject(:ability) {
      Ability.new FactoryGirl.build(:user)
    }

    it "should be able to read users" do
      expect(subject).to be_able_to(:read, User)
    end

    it "should not be able to edit users" do
      expect(subject).not_to be_able_to(:update, User)
    end

    it "should not be able to update users role" do
      expect(subject).not_to be_able_to(:update_role, User)
    end

    it "should not be able to destroy users" do
      expect(subject).not_to be_able_to(:destroy, User)
    end
  end
end
