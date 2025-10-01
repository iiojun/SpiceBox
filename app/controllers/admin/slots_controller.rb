class Admin::SlotsController < Admin::ApplicationController
  def create
    p = slot_params
    title = p[:title]
    t = Track.find(p[:tid])
    d = t.day
    date = (d.conference.start_date + d.seq_no).strftime("%Y-%m-%d")
    stime = date + sprintf(" %02d:%02d:00",
                     p["start_time(4i)"].to_i, p["start_time(5i)"].to_i)
    etime = date + sprintf(" %02d:%02d:00",
                     p["end_time(4i)"].to_i, p["end_time(5i)"].to_i)

    if !title
      flash[:alert] = "Title must be specified."
    elsif etime < stime
      flash[:alert] = "Wrong time format."
    else
      p.delete(:tid)
      yy, mm, dd = date.split("-")
      p["start_time(1i)"] = p["end_time(1i)"] = yy
      p["start_time(2i)"] = p["end_time(2i)"] = mm
      p["start_time(3i)"] = p["end_time(3i)"] = dd
      t.slots << Slot.create(p)
      flash[:notice] = "The session was registered."
    end
    redirect_to edit_admin_track_path(t)
  end

  def destroy
    s = Slot.find(params[:id])
    t = s.track
    s.destroy
    flash[:notice] = "The session was deleted."
    redirect_to edit_admin_track_path(t)
  end

  def edit
    @slot = Slot.find(params[:id])
  end

  def update
    p = slot_params
    title = p[:title]
    s = Slot.find(params[:id])
    t = s.track
    d = t.day
    date = (d.conference.start_date + d.seq_no).strftime("%Y-%m-%d ")
    stime = date + sprintf("%02d:%02d:00",
                     p["start_time(4i)"].to_i, p["start_time(5i)"].to_i)
    etime = date + sprintf("%02d:%02d:00",
                     p["end_time(4i)"].to_i, p["end_time(5i)"].to_i)

    if !title
      flash[:alert] = "Title must be specified."
    elsif etime < stime
      flash[:alert] = "Wrong time format."
    else
      s.update(p)
      flash[:notice] = "The session was updated."
    end
    redirect_to edit_admin_track_path(t)
  end

  private
  def slot_params
    params[:slot].each { |k, v| params[:slot][k] = nil if v.strip == "" }
    params.require(:slot).permit(:title, :description,
        :chair, :room, :s_type, :start_time, :end_time, :tid)
  end
end
