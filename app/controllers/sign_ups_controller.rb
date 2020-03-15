class SignUpsController < ApplicationController
  def index
  end

  def step1
      @user = User.new
  end

  def step2
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:first_name] = user_params[:first_name]
    session[:last_name] = user_params[:last_name]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    params[:birthday] = (birthday_join)
    session[:birthday] = params[:birthday]
    @user = User.new
  end

  def create
    session[:telephone_number] = user_params[:telephone_number]
    @user = User.new(
    nickname: session[:nickname],
    email: session[:email],
    first_name: session[:first_name],
    last_name: session[:last_name],
    first_name_kana: session[:first_name_kana],
    last_name_kana: session[:last_name_kana],
    birthday: session[:birthday],
    password: session[:password],
    password_confirmation: session[:password_confirmation],
    telephone_number: session[:telephone_number],
    )
   if @user.save
        session[:id] = @user.id
        redirect_to done_sign_ups_path
   else
      render  '/sign_ups/step1'
   end
  end

    def done
      sign_in User.find(session[:id]) unless user_signed_in?
    end

  private
  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :password,
      :password_confirmation,
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :birthday,
      :telephone_number,
    )
  end

  def birthday_join
    date = params[:birthday]
    if date["birthday(1i)"].empty? && date["birthday(2i)"].empty? && date["birthday(3i)"].empty?
      return
    end    
    Date.new date["birthday(1i)"].to_i, date["birthday(2i)"].to_i, date["birthday(3i)"].to_i
  end
end

