class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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
    respond_to do |format|
      if @user.save
        #Send mail to user by create delayed job
        @user.delay.user_send
        if @user.date_of_birth.strftime("%m") == Date.today.strftime("%m") && @user.date_of_birth.strftime("%d") == Date.today.strftime("%d")
          @user.delay(run_at: 1.seconds.from_now).send_wish(@user.id)
        end 
        #@user.delay(:queue => 'tracking').user_send
        #@user.delay(run_at: 1.minutes.from_now).user_send
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #Birthday reminder
  def send_wishes
    @users = User.all
    respond_to do |format|
      @users.each do |user|
        if user.date_of_birth.strftime("%m") == Date.today.strftime("%m") && user.date_of_birth.strftime("%d") == Date.today.strftime("%d")
          user.delay(run_at: 1.seconds.from_now).send_wish(user.id)
        end
      end
      format.html { redirect_to users_url, notice: 'Mail successfully send.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :date_to_receive, :date_of_birth)
    end
end
