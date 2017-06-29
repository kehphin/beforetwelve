class User < ApplicationRecord
  has_many :referrals, :class_name => 'Referral', :foreign_key => 'referrer_id'
  has_one :referred, :class_name => 'Referral', :foreign_key => 'referree_id'

  has_one :guestlist, dependent: :destroy

  def self.create_with_omniauth(auth, query_params)
    created_user = create! do |user|
      user.uid = auth['uid']
      user.superuser = false
      # user.referral_code = generate_referral_code
      if auth['info']
        user.image_url = auth['info']['image']
        user.first_name = auth['info']['first_name']
        user.last_name = auth['info']['last_name']
        user.name = "#{auth['info']['first_name']} #{auth['info']['last_name']}"
      end
    end

    referral = query_params['ref']
    if referral
      u = User.find_by(referral_code: referral)
      Referral.create(
        status: 'signed_up',
        referrer_id: u.id,
        referree_id: created_user.id
      )
    end

    created_user
  end

  def points_earned
    points = 0

    # signed up with referral = +25
    if referred
      points = points + 25
    end

    # referrals are +1 each (a Referral created when a referree goes thru signup flow)
    points = points + referrals.length

    # referrals where the referred person completed a loan = +100 for referee
    completed_referrals = referrals.select { |referral| referral.status == 'complete' }.size

    points = points + (completed_referrals * 100)
    points
  end

  def points_used
    # TODO array function for aggregating a value
    points = 0
    loan.each do |user_loan|
      if user_loan.points_used
        points = points + user_loan.points_used
      end
    end

    points
  end

  def total_points
    points_earned - points_used
  end

  # 4 random alphanumeric characters
  # def self.generate_referral_code
  #   [*('a'..'f'),*('A'..'F'),*('0'..'9')].shuffle[0,4].join
  # end
end
