class PostsController < ApplicationController
  # before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show index]
  def index
    @posts = current_user.posts.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new 
    @post = current_user.posts.new
  end 

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end
  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end
  
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end
  private

  def post_params 
    params.require(:post).permit(:title, :body,  :user_id, :current_user, pics:[])
  end 
end
