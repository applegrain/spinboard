require 'uri'

class Link < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :url, presence: true

  def self.valid_url?(url)
    u = URI.parse(url)
    u.kind_of?(URI::HTTP)
  end
end
