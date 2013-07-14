class LogsController < ActionController::Base
  before_filter :authenticate, only: :index

  layout "application"

  def notify
    Log.create! params.slice(:message, :url, :line)
    render nothing: true
  end

  def index
    @logs = Log.order_by('created_at desc').limit(500)
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "foo" && password == "bar"
    end
  end
end
