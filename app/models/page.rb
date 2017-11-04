class Page < ApplicationRecord
  has_many :page_contents, dependent: :destroy
  validates_presence_of :page_url
  after_create :parsed_page

  require 'nokogiri'
  require 'open-uri'

  # I used The Bastards Book of Ruby as a guideline
  # http://ruby.bastardsbook.com/chapters/html-parsing/

  def parsed_page
    response = Nokogiri::HTML(open(self.page_url))

    response.css('a').each do |link|
      self.page_contents.create( tag: 'a', content: link.content )
    end

    response.css('h1').each do |header|
      self.page_contents.create( tag: 'h1', content: header.content )
    end

    response.css('h2').each do |header|
      self.page_contents.create( tag: 'h2', content: header.content )
    end

    response.css('h3').each do |header|
      self.page_contents.create( tag: 'h3', content: header.content )
    end 

  end

end
