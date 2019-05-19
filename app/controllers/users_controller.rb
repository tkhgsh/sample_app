class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
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
    else
      #Failure
    # => @user.errors.full_messages()
       render 'edit'
    end
  end
  private
  #この後はすべてprivateになる。これを上書きされないようにする。外側からは呼び出されない。
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
