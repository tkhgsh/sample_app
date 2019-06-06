class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user       = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    #debugger
    # =>
  end
  
  def new
    @user = User.new
  end
  

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  #GET /users/:id/edit
  #params[:id] => :id
  def edit
    @user = User.find(params[:id])
    # => edit.html.erb
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params) ##必要な項目だけUpdateするSQLがは行される
      #Success
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      #Failure
    # => @user.errors.full_messages()
       render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  
  
  private
  #この後はすべてprivateになる。これを上書きされないようにする。外側からは呼び出されない。
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

  #before action, log in first
#　これはapplication controllerに動かす
#  def logged_in_user
#    unless logged_in?
#      store_location
#      flash[:danger] = "Please log in."
#      redirect_to login_url
#    end
#  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
end
