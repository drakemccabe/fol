class Stats
  def initialize
  end

  def last_month_donation_count
    Donation.where("created_at > ?", Date.today - 30).count
  end

  def last_year_donation_count
    Donation.where("created_at > ?", Date.today - 365).count
  end

  def last_month_donation_average
    Donation.where("created_at > ?", Date.today - 30).average(:amount).to_i
  end

  def last_year_donation_average
    Donation.where("created_at > ?", Date.today - 365).average(:amount).to_i
  end

  def last_month_donation_sum
    Donation.where("created_at > ?", Date.today - 30).sum(:amount).to_i
  end

  def last_year_donation_sum
    Donation.where("created_at > ?", Date.today - 365).sum(:amount).to_i
  end

  def membership_count
    Contact.joins(:memberships).where("expiration_date > ?", Date.today).count
  end

  def membership_new
    Contact.joins(:memberships).where("memberships.created_at > ?", Date.today - 30).count
  end
end
