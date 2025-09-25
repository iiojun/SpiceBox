class Day < ApplicationRecord
  has_many :tracks, dependent: :destroy
  belongs_to :conference

  def pdate
    I18n.l(conference.start_date + seq_no)
  end
end
