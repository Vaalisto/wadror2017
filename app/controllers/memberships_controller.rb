class MembershipsController < ApplicationController
	def index
    @membership = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show    
  end

  def new
    @membership = Membership.new
    @beer_clubs = BeerClub.all
  end

  def edit    
  end

  def create
    @membership = Membership.new(membership_params)
    @membership.user_id = current_user.id

    respond_to do |format|
      if @membership.save
        format.html { redirect_to :back, notice: 'Membership was successfully created.' }
        format.json { render json: @membership, status: :created, location: @membership }
      else
        format.html { render action: "new" }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:user_id, :beer_club_id, :confirmed)
    end

end