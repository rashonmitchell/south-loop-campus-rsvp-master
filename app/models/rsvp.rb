require 'csv'

class Rsvp
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name_one,    type: String
  field :name_two,    type: String
  field :name_three,  type: String
  field :bringing,    type: Fixnum

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << %w(first_name last_name email bringing created_at)
      all.each do |rsvp|
        csv << [rsvp.name_one, rsvp.name_two, rsvp.name_three, rsvp.bringing, I18n.l(rsvp.created_at, format: "%b %d %I.%M%p")]
      end
    end
  end
end
