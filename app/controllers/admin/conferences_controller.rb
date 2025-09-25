class Admin::ConferencesController < Admin::ApplicationController
  def show
    @conference = Conference.find(params[:id])
    @presentations = @conference.get_presentations
    @evaluated_presentations = @presentations.filter{|p| p.evaluated }
       .sort{|a,b| b.eval_score <=> a.eval_score }
    @not_evaluated_presentations = @presentations - @evaluated_presentations
  end

  def create
    p = conference_params
    if !p[:name]
      flash[:alert] = 'Name must be specified.'
    else
      c = Conference.create(p)
      p[:duration].to_i.times{|i|
        d = Day.create(title: "The day #{i+1}", seq_no: i)
        c.days << d
      }
      flash[:notice] = 'New conference was added.'
    end
    redirect_to admin_root_path
  end

  def destroy
    c = Conference.find(params[:id])
    c.get_evaluations&.each {|e| e.destroy }
    c.destroy
    flash[:notice] = 'The conference was deleted.'
    redirect_to admin_root_path
  end

  def edit
    @conference = Conference.find(params[:id])
  end

  def update
    c = Conference.find(params[:id])
    p = conference_params
    if !p[:name]
      flash[:alert] = 'Name must be specified.'
      redirect_to edit_admin_conference_path
    else
      c.update(p)
      flash[:notice] = 'The conference was updated.'
      redirect_to admin_root_path
    end
  end

  private
  def conference_params
    params[:conference].each{|k,v| 
      params[:conference][k] = nil if v.strip == ''}
    params.require(:conference).permit(:name, :description,
                                       :start_date, :duration)
  end
end
