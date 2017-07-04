class GuestsController < ApplicationController
  # before_action :set_loan, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!

  # GET /guests
  # GET /guests.json
  def index
    # @loans = Loan.all

    # if current_user.superuser
      # @loans = Loan.order('created_at DESC')
    # else
      @guests = Guest.order('created_at DESC')
    # end
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
  end

  # GET /loans/new
  def new
    # referral = params['ref']
    # TODO: optimize this
    # referred_user = User.find_by(referral_code: referral)&.guestlist
    # if referred_user
      @guest = Guest.new
    # end
  end

  # GET /loans/1/edit
  def edit
    # if (!current_user.superuser)
    #   redirect_to '/loans'
    # end
  end

  # POST /loans
  # POST /loans.json
  def create
    hash_params = guest_params.to_h
    # Find who's referral code they used and find the one-to-one guest list association
    # referred_guestlist_id = User.find_by(referral_code: hash_params['user_referral_code'])&.guestlist&.id
    # hash_params.delete('user_referral_code')

    # @guest = Guest.new(hash_params.merge(guestlist_id: referred_guestlist_id, masterlist_id: 1, name: "#{hash_params['first_name']} #{hash_params['last_name']}"))

    @guest = Guest.new(hash_params)
    @guest.save
    @submitted = true

    head :no_content

    # respond_to do |format|
    #   if @guest.save
    #     head :no_content
    #     # format.html { redirect_to '/guests?success=true', notice: 'Guest was successfully created.', something: 'else' }
    #     # format.json { render :show, status: :created, location: @guest }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @guest.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /loans/1
  # PATCH/PUT /loans/1.json
  def update

    respond_to do |format|
      if @loan.update(hash_params)
        if current_user.superuser
          format.html { redirect_to @loan, notice: 'Loan was successfully updated.' }
        else
          format.html { redirect_to '/loans?return=true', notice: 'Loan was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url, notice: 'Loan was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  # def set_loan
  #   @loan = Loan.find(params[:id])
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def guest_params
    params.required(:guest).permit(:first_name, :last_name, :name, :checked_in, :user_referral_code)
  end

  # def sorted_loans(loans)
  #   loans.sort_by { |loan| loan.created_at }
  # end

end
