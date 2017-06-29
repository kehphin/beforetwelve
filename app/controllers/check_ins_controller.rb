class CheckInsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user?, :except => [:index]

  def index
    @check_ins = CheckIn.order('created_at DESC')
  end
end
