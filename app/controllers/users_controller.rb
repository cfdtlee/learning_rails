class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
    # debugger
  end
  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def get_new_msg
    file_name = File.join(Rails.root, 'app', 'assets', 'data', 'messages.json')
    file = File.read(file_name)
    data_hash = JSON.parse(file)
    render json: data_hash
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
