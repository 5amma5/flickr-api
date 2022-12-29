class StaticPagesController < ApplicationController
  def index
    begin
      flickr = Flickr.new
      unless search_params[:user_id].blank?
        @photos = flickr.photos.search(user_id: search_params[:user_id], extras: :url_q)
      else
        @photos = flickr.photos.getRecent(extras: :url_q)
      end
    rescue StandardError => e
      flash[:alert] = "#{e.class}: #{e.message}."
      redirect_to root_path
    end
  end

  private

  def search_params
    params.permit(:user_id)
  end
end
