class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    # For safety, never accept the parameters directly from the web page
    # (really the POST request) as a fake page could push all sorts of
    # evil parameters back. So we filter the parameters using the private
    # method filtered_user_params that ensures the required parameter set
    # and the permitted parameters within that set (hash)
    @user = User.new(filter_user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Poetry"
      # We don't have a create_path page -- instead we show the 
      # profile for the user (e.g., the user page, which is a
      # redirect to the user show page).
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
  	@user = User.find params[:id]
  end

  private
    # Filter parameters coming from user web page (really, POST) to ensure
    # we only pay attention to the proper parameters. A malicious POST will
    # not put bogus junk into the instance or database.
    def filter_user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
