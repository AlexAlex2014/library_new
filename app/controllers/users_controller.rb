# frozen_string_literal: true

# class BooksController
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  def index
    authorize User

    @users = policy_scope(User)
  end

  # GET /users/new
  def new
    @user = current_user.users.new

    authorize @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.master_account = current_user.master_account_get
    @user.master = false
    @user.skip_confirmation!

    authorize @user

    if @user.save
      redirect_to @user, notice: 'save_success'
    else
      render :new
    end
  end

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    authorize @user

    if @user.update(user_params)
      redirect_to @user, notice: 'save_success'
    else
      render :edit
    end
  end

  def destroy
    authorize @user

    @user.destroy # unless @user.master?
    redirect_to users_path, notice: 'destroy_success'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
