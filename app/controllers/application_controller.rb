class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  add_flash_types :success, :error

  rescue_from CanCan::AccessDenied, with: :access_denied

  private

    def access_denied(e)
      respond_to do |format|
        format.json { head :forbidden, content_type: 'text/html' }
        format.html { redirect_back fallback_location: root_path, alert: e.message }
      end
    end
end
