class EvaluationsController < ApplicationController
  def update
    p = evaluation_params
    msg = 'updated'
    e = Evaluation.find_by(user: p[:user], presentation: p[:presentation])

    if !e
      e = Evaluation.create(comment: p[:comment])	
    end

    # judges_attributes must have all values!
    if e.questions.length != p[:judges_attributes].to_unsafe_hash.length
      flash[:alert] = 'All items in questions must be checked!'
    else
      if e.judges.length == 0
        e.questions.each_with_index do |q,i|
          e.judges << Judge.new(question: q, 
              value: p[:judges_attributes][i.to_s][:value].to_i)
        end
        User.find(p[:user]).evaluations << e
        Presentation.find(p[:presentation]).evaluations << e
        msg = 'registered'
      else
        e.update(comment: p[:comment])
        e.questions.each_with_index do |q,i|
          e.judges.find_by(question: q)
              .update(question: q, 
                  value: p[:judges_attributes][i.to_s][:value].to_i)
        end
      end
      flash[:notice] = "presentation evaluation was #{msg}."
    end
    redirect_to presentation_path p[:presentation]
  end

  private
  def evaluation_params
    params.require(:evaluation).permit(:user, :presentation, :comment,
                                       judges_attributes: [:value])
  end
end
