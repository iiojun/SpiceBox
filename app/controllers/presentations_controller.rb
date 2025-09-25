class PresentationsController < ApplicationController
  def show
    @presentation = Presentation.find(params[:id])
    if current_user && @presentation.evaluated
      @evaluation = Evaluation.find_by(user: current_user, 
                        presentation: @presentation)
      @update = (@evaluation != nil)
      if !@update
        @evaluation = Evaluation.new(user: current_user, 
           presentation: @presentation, comment: nil)
        for q in @evaluation.questions do
          @evaluation.judges << Judge.new(question: q, value: 0)
        end 
      end
    end
    pp = @presentation.slot.presentations.order(start_time: :asc)
    p_idx = pp.index(@presentation)
    @prev = p_idx > 0 ? pp[p_idx-1] : nil
    @next = p_idx < pp.length-1 ? pp[p_idx+1] : nil
  end
end
