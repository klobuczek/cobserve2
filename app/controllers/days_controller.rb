class DaysController < ApplicationController
  before_filter :login_required
  
  def edit
    date = Date.parse(params[:id])
    @day = current_user.day(date) || Day.new(:date=>date)
  end
  
  def update
    edit
    @day.user_id=current_user.id
    @day.update_attributes(params[:day])
    
    if "Save" === params[:commit]
      redirect_to_edit @day.date
    else
      redirect_to_edit @day.date + 1
    end
  end
  
  def destroy
    edit
    Day.delete(@day.id)
    redirect_to_edit @day.date
  end
  
  def index
    redirect_to_edit Date.today
  end
  
  private
  def redirect_to_edit date
    redirect_to :controller => "days", :action => "edit", :id => date.to_s
  end
end
