require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  attr_accessor :name, :location, :profile_url, :twitter, :linkedin, :github, :blog, :profile_quote, :bio


  def self.scrape_profile_page(profile_url)

    profile_page = Nokogiri::HTML(open(profile_url))



    student = {}

    links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}

    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end

    # social_profile = profile_page.css("div.vitals-container").css("a")

    # array_1 = social_profile.map do |link|
    #   link.attribute("href").value
    # end
    #         array_1.each do |link|
    #           link.include?("github")
    #             student[:github] = link
    #           link.include?("twitter")
    #             student[:twitter] = link
    #           link.include?("linkedin")
    #             student[:linkedin] = link

    student[:profile_quote] = profile_page.css("div.profile-quote").text unless !:profile_quote
    student[:bio] = profile_page.css("div.description-holder").css("p").text unless !:bio

    student
  end


  def self.scrape_index_page(index_url)

    index_page = Nokogiri::HTML(open(index_url))

    students = []
    # index_page.css("div.roster-cards-container").each do |student|

    # student_name = student.css("h4").first.text
    # student_location = student.css("p").first.text
    # student_profile_url = student.css("a")[0].first[1]
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|

        student_profile_link = "#{student.attr('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text

    students <<
    {
      :name  => student_name, :location  => student_location, :profile_url  => student_profile_link
    }
      end
    end
    students
  end

end

