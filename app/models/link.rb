require 'uri'

class Link < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :url, presence: true

  def self.service
    @service ||= LinkService.new
  end

  def service
    self.class.service
  end

  def display_summary
    if Link.valid_url?(self.url)
      resp = service.fetch_url_data(self.url)
      unless resp.empty?
        start = resp.index(">") + 1
        finish = resp.index("</") -1
        resp[start..finish]
      end
    end
  end

  def self.valid_url?(url)
    u = URI.parse(url)
    u.kind_of?(URI::HTTP)
  end
end
