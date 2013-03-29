class AlbumsController < ApplicationController

  before_filter :find_album, except: [:create_comment]

  def show

  end

  def create_comment
    comment = Utils::Picasa::Comment.create(params[:id], params[:picasa_comment])
    if comment
      redirect_to :back, flash: { notice: 'Comment created!' }
    else
      redirect_to :back, flash: { error: 'We have some problems during create a comment =( try again!' }
    end
  end

  private

  def find_album
    @album = Utils::Picasa::Api.find(:album, params[:id])
    @album.load_photos()
  end


end
