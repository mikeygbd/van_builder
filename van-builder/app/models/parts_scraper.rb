require 'open-uri'
require 'nokogiri'

class PartsScraper
  attr_accessor :image_urls, :recomended_parts, :listings
  @recomended_parts = []
    @image_url =''

    def self.recomended_parts
      @recomended_parts
    end

    def self.image_url
      @image_url
    end


    def self.scrape_part(url)
      doc = Nokogiri::HTML(open(url))
      @image_url = doc.search('#res').search('img').attr('src').text
      # @part_price = doc.search('div.e10twf.T4OwTb').search('span').text
    end

    def self.scrape_campervanhq
      doc = Nokogiri::HTML(open("https://www.campervan-hq.com/collections"))
      parts_list = doc.search('div.grid-item.large--one-fifth.medium--one-half')
      parts_list.each do |individual_part|
      @recomended_parts << {:part_name => individual_part.search('p').text, :url => individual_part.search('img').attr('src').text, :page_link => "https://www.campervan-hq.com#{individual_part.search('a.product-grid-item').attr('href').text}"}
      end
    end

end
