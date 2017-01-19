require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    sign_in(FactoryGirl.create(:user, :admin, email: Faker::Internet.email))
  end

  let(:user) do
    FactoryGirl.create(:user)
  end

  let(:valid_attributes) do
    { email: "test@local.fr", first_name: Faker::Name.first_name, last_name: Faker::Name::last_name, role: :user }
  end

  let(:invalid_attributes) do
    { email: "bademail", first_name: "", last_name: "", created_by_admin: true }
  end

  let(:valid_session) do
    {}
  end

  describe "GET #index" do
    it "assigns all users as @users" do
      get :index, params: {}, session: valid_session
      expect(assigns(:users).count).to eq(1)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "responds to html by default" do
      get :index
      expect(response.content_type).to eq("text/html")
    end

    it "responds to custom formats when provided in the params" do
      get :index, format: :json
      expect(response.content_type).to eq "application/json"
    end
  end

  describe "GET #show" do
    it "assigns the requested user as @user" do
      get :show, params: {id: user.to_param}, session: valid_session
      expect(assigns(:user)).to eq(user)
    end

    it "responds to html by default" do
      get :show, params: {id: user.to_param}, session: valid_session
      expect(response.content_type).to eq("text/html")
    end

    it "responds to custom formats when provided in the params" do
      get :show, params: {id: user.to_param}, format: :json, session: valid_session
      expect(response.content_type).to eq "application/json"
    end
  end

  describe "GET #new" do
    it "assigns a new user as @user" do
      get :new, params: {}, session: valid_session
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "GET #edit" do
    it "assigns the requested user as @user" do
      get :edit, params: {id: user.to_param}, session: valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: {user: valid_attributes}, session: valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, params: {user: valid_attributes}, session: valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the created user" do
        post :create, params: {user: valid_attributes}, session: valid_session
        expect(response).to redirect_to(user_path(User.last))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, params: {user: invalid_attributes}, session: valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, params: {user: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        { first_name: "abc", last_name: "defg", role: :admin }
      end

      it "updates the requested user" do
        put :update, params: {id: user.to_param, user: new_attributes}, session: valid_session
        user.reload
        expect(user.first_name).to eq("Abc")
        expect(user.last_name).to eq("DEFG")
        expect(user.role).to eq("admin")
      end

      it "assigns the requested user as @user" do
        put :update, params: {id: user.to_param, user: valid_attributes}, session: valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "redirects to the user" do
        put :update, params: {id: user.to_param, user: valid_attributes}, session: valid_session
        expect(response).to redirect_to(user_path(user))
      end
    end

    context "with invalid params" do
      it "assigns the user as @user" do
        put :update, params: {id: user.to_param, user: invalid_attributes}, session: valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        put :update, params: {id: user.to_param, user: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "PUT #update_role" do
    let(:valid_attributes) do
      { role: :admin }
    end

    let(:invalid_attributes) do
      { role: :admin, first_name: "new" }
    end

    context "with valid params" do
      it "updates the requested user role" do
        put :update_role, params: {id: user.to_param, user: valid_attributes}, session: valid_session
        user.reload
        expect(user.role).to eq("admin")
      end

      it "redirect to the users list" do
        put :update_role, params: {id: user.to_param, user: valid_attributes}, session: valid_session
        expect(response).to redirect_to(users_path)
      end
    end

    context "with invalid params" do
      it "update only user role attribute" do
        put :update_role, params: {id: user.to_param, user: invalid_attributes}, session: valid_session
        user.reload
        expect(user.role).to eq("admin")
        expect(user.name).not_to eq("new")
      end

      it "redirect to the users list" do
        put :update_role, params: {id: user.to_param, user: invalid_attributes}, session: valid_session
        expect(response).to redirect_to(users_path)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user
      expect {
        delete :destroy, params: {id: user.to_param}, session: valid_session
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      delete :destroy, params: {id: user.to_param}, session: valid_session
      expect(response).to redirect_to(users_url)
    end
  end
end
