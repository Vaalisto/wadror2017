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
    bc = BeerClub.find_by id: @membership.beer_club_id

    if bc.members.include? current_user
      redirect_to beer_clubs_path, notice: "You can join only once!"    
    else
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
  end

  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user.id), notice: 'Membership was successfully ended.' }
      format.json { head :no_content }
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