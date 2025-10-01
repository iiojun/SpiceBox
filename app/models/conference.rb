class Conference < ApplicationRecord
  has_many :days, dependent: :destroy

  def get_presentations
    p = []
    self.days.each { |d|
      d.tracks.each { |t|
        t.slots&.each { |s| p += s.presentations }}}
    return p
  end

  def get_evaluations
    e = []
    self.get_presentations&.each { |p| e += p.evaluations }
    return e
  end
end
