class Evaluation < ApplicationRecord
  has_many :judges, dependent: :destroy
  accepts_nested_attributes_for :judges
  belongs_to :user
  belongs_to :presentation

  @@questions = ['Is this talk applicable to your school?',
      'Is this talk interesting?',
      'Do you find originarity in this talk?',
      'Did students have fun in this program?',
      'Is this program useful to acquire the intercultual understanding?']

  def questions
    return @@questions
  end

  def total_score
    return 100*self.judges.sum{|j| j.value.to_i}/(5*@@questions.length)
  end
end
