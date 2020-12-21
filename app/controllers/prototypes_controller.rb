class PrototypesController < ApplicationController
  before_action :move_to_index, only: [:edit]
  before_action :authenticate_user!, except: [:index, :show]
  
  # before_action :authenticate_user! ,expect: [:index] indexアクション以外にauthenticate_user!メソッドを適用させる
  # before_action :authenticate_user!
  # only,exceptを用いて、特定のアクションのみを設定する。

  def index
    @prototypes = Prototype.all
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
    @comment = Comment.new
    @comments = @prototype.comments
 end
  
  def edit
    @prototype = Prototype.find(params[:id])
  
  end
  
  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end
  
  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render edit
    end
  end
  
  private
    def prototype_params
      params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
    end
    
    def move_to_index
      # unless user_signed_in?
      @prototype = Prototype.find(params[:id])
      unless @prototype.user == current_user
        redirect_to action: :index
      end
    end

  end