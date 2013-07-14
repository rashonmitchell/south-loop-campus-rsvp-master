class Log
  include Mongoid::Document
  include Mongoid::Timestamps

  field :message, type: String
  field :url,     type: String
  field :line,    type: String
end
