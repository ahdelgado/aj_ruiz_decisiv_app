class UrlsController < ApplicationController
  def index
    @urls = Url.paginate(page: params[:page])
  end

  def new
    @url = Url.new
  end

  def show
    @url = Url.find(params[:id])
  end
  
  def create
    @url = Url.new(url_params)
    if @url.save
      flash[:success] = "Short URL generated!"
      redirect_to @url
    else
      render 'new'
    end
  end
  
  def destroy
  end
  
  private

    def url_params
      params.require(:url).permit(:long_url, :short_url)
    end

end
