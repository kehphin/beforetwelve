class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  # GET /loans
  # GET /loans.json
  def index
    # @loans = Loan.all

    if current_user.superuser
      @loans = Loan.order('created_at DESC')
    else
      @loans = Loan.order('created_at DESC').where(user_id: current_user.id)
    end
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
  end

  # GET /loans/new
  def new
    @loan = Loan.new
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
    hash_params = loan_params.to_h

    if hash_params['due_at'].present?
      hash_params['due_at'] = Date.strptime(hash_params['due_at'], '%m/%d/%Y')
    end

    if hash_params['keys']
      hash_params['keys'] = hash_params['keys'].to_i
    end

    if hash_params['points_used'].present?
      hash_params['points_used'] = hash_params['points_used'].to_i * 100
    end

    @loan = Loan.new(hash_params.merge({ user_id: current_user.id, status: 'pending' }))

    respond_to do |format|
      if @loan.save

        SubmittedLoanMailer.send_email(@loan).deliver_now

        format.html { redirect_to '/loans?success=true', notice: 'Loan was successfully created.', something: 'else' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loans/1
  # PATCH/PUT /loans/1.json
  def update
    if params['loan'].present? && loan_params.present?
      hash_params = loan_params.to_h
    else
      hash_params = {}
    end

    if hash_params.empty? && !current_user.superuser
      hash_params['status'] = 'returning'
      ReturningLoanMailer.send_email(@loan).deliver_now
    end

    if hash_params['due_at'].present?
      hash_params['due_at'] = Date.strptime(hash_params['due_at'], '%m/%d/%Y')
    end

    # if the loan was completed, we update the referral if applicable
    if hash_params['status'] == 'completed'
      referral = Referral.find_by(referree_id: @loan.user_id)
      if referral
        referral.update(status: 'completed')
      end
    end

    # if updated to approved, we email the user
    if hash_params['status'] == 'accepted'
      ApprovedLoanMailer.send_email(@loan).deliver_now
    end

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
  def set_loan
    @loan = Loan.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def loan_params
    params.required(:loan).permit(:first_name, :last_name, :checked_in)
  end

  def sorted_loans(loans)
    loans.sort_by { |loan| loan.created_at }
  end

end
