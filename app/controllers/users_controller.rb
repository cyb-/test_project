class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :edit_role, :update_role, :destroy]
  authorize_resource

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.created_by_admin!
    # @user.skip_confirmation!
    # user_created = @user.save
    @user.invite!(current_user) if user_created = @user.save

    respond_to do |format|
      if user_created
        format.html { redirect_to @user, success: t("flashes.created", model: t("activerecord.models.user")) }
        format.json { render :show, status: :created, location: user_url(@user) }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user.update(user_params)
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, success: t("flashes.updated", model: t("activerecord.models.user")) }
        format.json { render :show, status: :ok, location: user_url(@user) }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_role
  end

  def update_role
    @user.update(update_role_params)
    respond_to do |format|
      if @user.update(update_role_params)
        format.html { redirect_to users_path, success: t("flashes.updated", model: t("activerecord.models.user")) }
        format.json { render :show, status: :ok, location: user_url(@user) }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, success: t("flashes.destroyed", model: t("activerecord.models.user")) }
      format.json { head :no_content }
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :role)
    end

    def update_role_params
      params.require(:user).permit(:role)
    end
end
