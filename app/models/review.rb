class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"
  
  
  validates :description, presence: true
  validates :rating, presence: true
  validates :reservation, presence: true
  validate :res_passed

  private

  def res_passed
    if reservation
      if self.reservation.checkout > Date.today
        errors.add(:reservation, "did not pass")
      end
    end
  end
end
