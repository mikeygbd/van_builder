require 'open-uri'
require 'nokogiri'
class VanScraper
  attr_accessor :image_urls, :listings
  @image_url =''

  def self.image_url
    @image_url
  end

  def self.scrape_van(url)
    doc = Nokogiri::HTML(open(url))
    @image_url = doc.search('#res').search('img').attr('src').text
  end
end
