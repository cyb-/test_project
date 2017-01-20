require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes) do
    { email: 'test@local.fr', password: 'please123', password_confirmation: 'please123', first_name: 'abc', last_name: 'defg' }
  end

  subject do
    FactoryGirl.build(:user)
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without email" do
    subject.email = ''
    expect(subject).not_to be_valid
  end

  it "is not valid with invalid email" do
    subject.email = 'invalidemail'
    expect(subject).not_to be_valid
  end

  it "is not valid with already taken email" do
    FactoryGirl.create(:user)
    expect(subject).not_to be_valid
  end

  it "is not valid without first_name" do
    subject.first_name = ''
    expect(subject).not_to be_valid
  end

  it "is not valid without last_name" do
    subject.last_name = ''
    expect(subject).not_to be_valid
  end

  describe "password validations" do
    it "failed without password" do
      subject.password = ''
      expect(subject).not_to be_valid
    end

    it "failed with invalid password_confirmation" do
      subject.password_confirmation = 'mismatch'
      expect(subject).not_to be_valid
    end
  end

  describe "format attributes" do
    it "first_name should be capitalized" do
      user = User.create!(valid_attributes)
      expect(user.first_name).to eq('Abc')
    end

    it "last_name should be upcased" do
      user = User.create!(valid_attributes)
      expect(user.last_name).to eq('DEFG')
    end

    it "should have name concat from first_name and last_name" do
      user = User.create!(valid_attributes)
      expect(user.name).to eq('Abc DEFG')
    end
  end

  describe "role definition" do
    it "first created should be an admin"do
      subject.save
      expect(subject.role).to eq('admin')
    end

    it "second created should be a user" do
      subject.save
      user = FactoryGirl.create(:user, email: Faker::Internet.email)
      expect(user.role).to eq('user')
    end
  end

  describe "created by admin" do
    it "should be valid without password" do
      subject.created_by_admin!
      subject.password = ''
      expect(subject).to be_valid
    end
  end
end
