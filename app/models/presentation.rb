class Presentation < ApplicationRecord
  has_many :evaluations
  has_many :users, through: :evaluation
  belongs_to :slot

  def ptime
    start_time.strftime("%H:%M") + ' - ' + end_time.strftime("%H:%M")
  end

  def eval_num
    evaluations = self.evaluations
    evaluations ? evaluations.length : 0
  end

  def eval_score
    num_eval = self.eval_num.to_f
    (num_eval > 0.0) ? self.evaluations.sum{|e| e.total_score}/num_eval : 0.0
  end

  def comments
    self.evaluations&.map{|e| e.comment.strip }.filter{|x| x != ''}
  end

  def comment_strings
    self.evaluations&.map{|e| e.comment.strip }.filter{|x| x != ''}.join("\n")
  end
end
