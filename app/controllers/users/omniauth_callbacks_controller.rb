# -*- encoding : utf-8 -*-
class Users::OmniauthCallbacksController < ApplicationController

  def auth
    user_data = Hashie::Mash.new(auth_hash)
    sing_in(user_data)
    redirect_to root_path
  end


  [:google].each { |provider| alias_method provider, :auth }

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end