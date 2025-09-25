class Admin::PresentationsController < Admin::ApplicationController
  def show
    @presentation = Presentation.find(params[:id])
  end

  def create
    p = presentation_params
    title = p[:title]
    s = Slot.find(p[:sid])
    d = s.track.day
    date = (d.conference.start_date + d.seq_no).strftime("%Y-%m-%d ")
    stime = date + sprintf("%02d:%02d:00",
                     p['start_time(4i)'].to_i, p['start_time(5i)'].to_i)
    etime = date + sprintf("%02d:%02d:00",
                     p['end_time(4i)'].to_i, p['end_time(5i)'].to_i)

    if !title
      flash[:alert] = 'Title must be specified.'
    elsif etime < stime
      flash[:alert] = 'Wrong time format.'
    else
      p.delete(:sid)
      s.presentations << Presentation.create(p)
      flash[:notice] = 'The presentation was registered.'
    end
    redirect_to edit_admin_slot_path(s)
  end

  def destroy
    p = Presentation.find(params[:id])
    s = p.slot
    p.destroy
    flash[:notice] = 'The presentation was deleted.'
    redirect_to edit_admin_slot_path(s)
  end

  def edit
    @presentation = Presentation.find(params[:id])
  end

  def update
    p = presentation_params
    title = p[:title]
    pr = Presentation.find(params[:id])
    s = pr.slot
    d = s.track.day
    date = (d.conference.start_date + d.seq_no).strftime("%Y-%m-%d ")
    stime = date + sprintf("%02d:%02d:00",
                     p['start_time(4i)'].to_i, p['start_time(5i)'].to_i)
    etime = date + sprintf("%02d:%02d:00",
                     p['end_time(4i)'].to_i, p['end_time(5i)'].to_i)

    if !title
      flash[:alert] = 'Title must be specified.'
    elsif etime < stime
      flash[:alert] = 'Wrong time format.'
    else
      p.delete(:sid)
      pr.update(p)
      flash[:notice] = 'The presentation was updated.'
    end
    redirect_to edit_admin_slot_path(s)

  end

  private
  def presentation_params
    params[:presentation].each{|k,v|
      params[:presentation][k] = nil if v.strip == ''}
    params.require(:presentation).permit(:title, :authors, :presenter,
        :description, :contact_email, :url, :misc, :evaluated, :apply_journal,
        :start_time, :end_time, :sid)
  end
end
