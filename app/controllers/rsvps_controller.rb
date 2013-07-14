class RsvpsController < ApplicationController
  before_filter :authenticate, only: :index
  before_filter :set_locale

  def create
    Rsvp.create!(params.slice(:name_one, :name_two, :name_three, :bringing))
    render json: {ok: true}
  end

  def index
    @rsvps = Rsvp.all
    respond_to do |format|
      format.html {render "index" }
      format.csv { send_data @rsvps.to_csv }
      format.xls  { send_data @rsvps.to_csv(col_sep: "\t") }
    end
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "foo" && password == "bar"
    end
  end

  def set_locale
    I18n.locale = :en
  end
end
