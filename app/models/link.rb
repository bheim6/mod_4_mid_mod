require 'uri'

class Link < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
  validates :url, presence: true
  # validate :is_url_valid

  def is_url_valid
    if url
      uri = URI.parse(url)
      unless uri.kind_of?(URI::HTTP) or uri.kind_of?(URI::HTTPS)
        errors.add(:url, "Please use a valid URL")
      end
    end
  end
end
