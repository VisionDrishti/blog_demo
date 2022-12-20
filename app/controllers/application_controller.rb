class ApplicationController < ActionController::Base
  before_action :set_notifications, if: :current_user
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_categories

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name,:last_name ,:avatar , address_attributes: [ :city, :state, :street, :zip]])
  end
  def profile
    @user.update(views: @user.views + 1)
    @posts = @user.posts.includes(:rich_text_body).order(created_at: :desc)
    @total_views = 0

    @posts.each do |post|
      @total_views += post.views
    end
  end

  def is_admin?
    unless current_user&.admin?
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to root_path
    end
  end

private 
  def set_categories
    @nav_categories = Category.where(display_in_nav: true).order(:name)
  end



  def set_notifications
    notifications = Notification.includes(:recipient).where(recipient: current_user).newest_first.limit(9)
    @unread = notifications.unread
    @read = notifications.read
  end
end
