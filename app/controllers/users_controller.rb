class UsersController < ApplicationController
def show
  @user = User.find(params[:id])
  @prototype = @user.name
  @prototypes = @user.prototypes.includes(:user)
end

end
