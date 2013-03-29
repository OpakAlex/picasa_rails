class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_token, :if => Proc.new { |c| c.current_user }, except: [:logout]
  before_filter :find_albums, :if => Proc.new { |c| c.current_user }, except: [:logout, :create_comment]


  helper_method :current_user

  protected

  def sing_in user
    session[:user] = user
  end

  def current_user
    session[:user]
  end

  def logout
    session[:user] = nil
  end

  def find_albums
    Utils::Picasa::Api.new(user_id: current_user.uid, token: current_user.credentials.try(:token))
    @albums ||=  Utils::Picasa::Api.get_albums()
  end

  def check_token
    unless current_user.credentials.expires_at.to_i > Time.now.to_i
      redirect_to "/logout"
    end
  end

end
