class Admin::UsersController < Admin::ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def update
   u = User.find(params[:id])
   p = user_params
   if p[:password] != ""
     u.update(p)
   else
     u.update(fullname: p[:fullname], role: p[:role])
   end
   flash[:notice] = "The user was updated."
   redirect_to admin_root_path
  end

  def destroy
    User.destroy(params[:id])
    flash[:notice] = "The user was deleted."
    redirect_to admin_root_path
  end

  private
  def user_params
    params.require(:user).permit(:fullname, :password, :role)
  end
end
