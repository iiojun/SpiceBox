class Admin::TracksController < Admin::ApplicationController
  def edit
    @track = Track.find(params[:id])
  end

  def update
    t = Track.find(params[:id])
    p = track_params
    title = p[:title]
    desc = p[:description]
    if !title
      flash[:alert] = "Title must be specified."
      redirect_to edit_admin_track_path(t)
    else
      t.title = title
      t.description = desc
      t.save
      flash[:notice] = "Track was updated."
      redirect_to edit_admin_day_path(t.day)
    end
  end

  private
  def track_params
    params[:track].each { |k, v| params[:track][k] = nil if v.strip == "" }
    params.require(:track).permit(:title, :description)
  end
end
