class Slot < ApplicationRecord
  has_many :presentations, dependent: :destroy
  belongs_to :track

  def pdatetime
    I18n.l(start_time) + " " + ptime
  end

  def ptime
    start_time.strftime("%H:%M") + " - " +
      end_time.strftime("%H:%M")
  end
end
