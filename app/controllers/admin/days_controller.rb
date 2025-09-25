class Admin::DaysController < Admin::ApplicationController
  def edit
    @day = Day.find(params[:id])
  end

  def update
    d = Day.find(params[:id])
    p = day_params
    title = p[:title]
    desc = p[:description]
    num_track = p[:num_track]
    if !title
      flash[:alert] = 'Title must be specified.'
      redirect_to edit_admin_day_path(d)
    else
      d.title = title
      d.description = desc
      d.save
      if num_track != nil || num_track == ''
        num_track.to_i.times{|i|
          d.tracks <<
            Track.create(title: 'The track ' + (i+1).to_s, seq_no: i)
        }
        flash[:notice] = 'Tracks are added.'
        redirect_to edit_admin_day_path(d)
        return
      end
      flash[:notice] = 'The day was updated.'
      redirect_to edit_admin_conference_path(d.conference)
    end
  end

  private
  def day_params
    params[:day].each{|k,v| params[:day][k] = nil if v.strip == ''}
    params.require(:day).permit(:title, :description, :num_track)
  end
end
