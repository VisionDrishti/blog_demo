class PostsController < ApplicationController

  before_action :authenticate_user!, except: %i[show index]
  def index
    @posts = Post.all.includes(:user,:rich_text_body)
  end

  def show
    @post = Post.find(params[:id])

    mark_notifications_as_read
  end

  

  def new 
    @post = current_user.posts.new
  end 

  def create
    @post = Post.new(post_params)
    @post.user = current_user

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

  def mark_notifications_as_read
    if current_user
      notifications_to_mark_as_read = @post.notifications_as_post.where(recipient: current_user)
      notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
    end
  end 
end
