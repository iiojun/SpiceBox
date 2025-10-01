class Evaluation < ApplicationRecord
  has_many :judges, dependent: :destroy
  accepts_nested_attributes_for :judges
  belongs_to :user
  belongs_to :presentation

  @@questions = [
      "Practical Originality and Ingenuity (Method)",
      "Originality of Practice (Materials)",
      "Educational Effectiveness and Student Learning",
      "Continuity and Development",
      "Clarity of Materials and Presentations"
  ]

  def questions
    return @@questions
  end

  def total_score
    return 100*self.judges.sum { |j| j.value.to_i } / (5*@@questions.length)
  end
end
