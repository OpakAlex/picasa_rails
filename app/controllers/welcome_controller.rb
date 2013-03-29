class WelcomeController < ApplicationController

  def index
  end

  def logout
    super
    redirect_to root_path, flash: { notice: 'You are not auth user' }
  end

end
