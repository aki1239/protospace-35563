class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :move_to_index, except: [:index, :show]
  before_action :baria_user, only: [:edit, :destroy, :update]
  def index
    @prototypes = Prototype.all#find_by_sql(query)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
    redirect_to root_path
    else
    render :new
    end
  end
    
   def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new(prototype_id: @prototype_id)
    @comments = @prototype.comments.includes(:user)
   end
    def edit
    @prototype = Prototype.find(params[:id])
    end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
        redirect_to prototype_path
    else
      @prototype = prototype
      render :edit
    end

  end
  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.destroy
      redirect_to root_path
    end    
  end


  private
  def prototype_params
  params.require(:prototype).permit(:image, :text, :title, :catch_copy, :concept).merge(user_id: current_user.id)
  end

  def baria_user
    unless Prototype.find(params[:id]).user.id.to_i == current_user.id
        redirect_to root_path(current_user)
    end
  end
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end



end