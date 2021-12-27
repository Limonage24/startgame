class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :require_login, only: %i[new create]
  before_action :admin_access, only: %i[index]
  before_action :is_current, only: %i[edit show destroy]


  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    found = User.find_by_username(user_params[:username])
    respond_to do |format|
      if !found && @user.save
        sign_in @user
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, alert: "Such user already exists", status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, alert: "Such user already exists", status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
    @posts = Post.where("author = #{@user.id}").all
  end

    # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:avatar, :username, :password, :password_confirmation)
  end
end
