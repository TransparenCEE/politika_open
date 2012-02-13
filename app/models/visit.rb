class Visit < ActiveRecord::Base
  belongs_to :user
  
  validates_uniqueness_of :session_id, scope: [:user_id, :access_date]
  
  def self.top_users
    group(:user_id).select('id, user_id, count(user_id) as visit_count').order('visit_count DESC').limit(5).map(&:user)
  end
end
