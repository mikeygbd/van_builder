require 'open-uri'
require 'nokogiri'
class VideoScraper
  attr_accessor :image_urls, :listings
  @image_url =''

  def self.image_url
    @image_url
  end

  def self.scrape_video(url)
    doc = Nokogiri::HTML(open(url))
    @image_url = doc.search('#ytd-player').search('video').attr('src').text
  end
end
