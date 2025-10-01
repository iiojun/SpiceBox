class Evaluation < ApplicationRecord
  has_many :judges, dependent: :destroy
  accepts_nested_attributes_for :judges
  belongs_to :user
  belongs_to :presentation

  @@questions = [
      "1. Practical Originality and Ingenuity (Method)",
      "2. Originality of Practice (Materials)",
      "3. Educational Effectiveness and Student Learning",
      "4. Continuity and Development",
      "5. Clarity of Materials and Presentations"
  ]

  def questions
    return @@questions
  end

  def total_score
    return 100*self.judges.sum { |j| j.value.to_i } / (5*@@questions.length)
  end
end
