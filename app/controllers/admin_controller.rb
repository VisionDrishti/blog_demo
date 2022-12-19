class AdminController < ApplicationController
  before_action :authenticate_user!
  def index
  end


  def posts
    @posts = Post.all.includes(:user, :comments)
  end


  def comments
    @comments = Comment.all.includes(:user, :comments)
  end

  def users
    @users = User.all
  end


  def show_post
    @post = Post.includes(:user, :comments).find(params[:id])
  end
end