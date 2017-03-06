class RatingsController < ApplicationController
  before_action :skip_if_cached, only: [:index]

  def index
    @best_beers = Beer.includes(:ratings).top(3)
    @best_breweries = Brewery.includes(:ratings).top(3)
    @best_styles = Style.includes(:ratings).top(3)    
    @recent = Rating.includes(:beer, :user).recent    
    @users = User.includes(:ratings).most_active(5)    
  end

  def new
  	@rating = Rating.new
  	@beers = Beer.all
  end

  def create
  	@rating = Rating.new(rating_params)
    
    if current_user.nil?
      redirect_to signin_path, notice:'Please, sign in'
    elsif @rating.save
      current_user.ratings << @rating
  	  redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end

  def skip_if_cached
    return render :index if request.format.html? and fragment_exist?( 'ratinglist' )
  end

  private
    def rating_params
      params.require(:rating).permit(:score, :beer_id)
    end
end