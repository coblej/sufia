class StaticController < ApplicationController
  rescue_from AbstractController::ActionNotFound, :with => :render_404

  def zotero
    respond_to do |format|
      format.html
      format.js { render :layout => false }
    end
  end
  def mendeley
    respond_to do |format|
      format.html
      format.js { render :layout => false }
    end
  end
end
