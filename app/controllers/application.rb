# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'de993d86d99ae084a8640996a11cdde7'
  
  layout("base")
  
#  before_filter :get_user
#  
#  def authorize
#    return true if @u
#    report_error("Unauthorized access; password required")
#  end
#  
#  def get_user
#    if session['user']
#      @u = User.find_by_id(session['user'])
#    end
#  end
#  
#  private
#  def report_error(message)
#    @message = message
#    render :action => "error"
#    return false
#  end
#  
#  
#  
end
