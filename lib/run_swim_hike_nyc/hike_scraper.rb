require 'pry'
require 'nokogiri'
require 'open-uri'

class HikeScraper

  attr_accessor :prop_id, :names, :location, :park_name, :length, :difficulty, :other_details, :accessible, :borough
  @@hike = {}

  def initialize
    @prop_id = []
    @names = []
    @location = []
    @park_name = []
    @length = []
    @difficulty = []
    @other_details = []
    @accessible = []
    @borough = []
  end

  def call
    collect_and_create
  end

  def collect_and_create
    xml = open("http://www.nycgovparks.org/bigapps/DPR_Hiking_001.xml")
    doc = Nokogiri::HTML(xml)
    facilities = doc.xpath("//facility")
    prop_id = facilities.xpath("//prop_id")
    names = facilities.xpath("//name")
    location = facilities.xpath("//location")
    park_name = facilities.xpath("//park_name")
    length = facilities.xpath("//length")
    difficulty = facilities.xpath("//difficulty")
    other_details = facilities.xpath("//other_details")
    accessible = facilities.xpath("//accessible")

    prop_id.each do |id|
      @prop_id << id.text.to_s
      @@hike[:prop_id] = @prop_id
    end

    names.each do |name|
      @names << name.text.to_s
      @@hike[:names] = @names
    end

    location.each do |location|
      @location << location.text.to_s
      @@hike[:location] = @location
    end

    park_name.each do |park_name|
      @park_name << park_name.text.to_s
      @@hike[:park_name] = @park_name
    end

    length.each do |length|
      @length << length.text.to_s
      @@hike[:length] = @length
    end

    difficulty.each do |difficulty|
      @difficulty << difficulty.text.to_s
      @@hike[:difficulty] = @difficulty
    end
    
    other_details.each do |other_details|
      @other_details << other_details.text.to_s
      @@hike[:other_details] = @other_details
    end

    accessible.each do |accessible|
      @accessible << accessible.text.to_s
      @@hike[:accessible] = @accessible
    end

    @@hike[:names].each do |name|
      temp = Hike.new(name)
    end

    counter = 0
    Hike.all.each do |instance|
      instance.prop_id = @@hike[:prop_id][counter]
      if instance.prop_id.start_with?("X")
        instance.borough = "Bronx"
      elsif instance.prop_id.start_with?("B")
        instance.borough = "Brooklyn"
      elsif instance.prop_id.start_with?("M")
        instance.borough = "Manhattan"
      elsif instance.prop_id.start_with?("Q")
        instance.borough = "Queens"
      elsif instance.prop_id.start_with?("R")
        instance.borough = "Staten Island"
      end
      counter += 1
    end

    counter = 0
    Hike.all.each do |instance|
      instance.location = @@hike[:location][counter]
      counter += 1
    end

    counter = 0
    Hike.all.each do |instance|
      instance.park_name = @@hike[:park_name][counter]
      counter += 1
    end

    counter = 0
    Hike.all.each do |instance|
      instance.length = @@hike[:length][counter]
      counter += 1
    end

    counter = 0
    Hike.all.each do |instance|
      instance.difficulty = @@hike[:difficulty][counter]
      counter += 1
    end

    counter = 0
    Hike.all.each do |instance|
      instance.other_details = @@hike[:other_details][counter]
      counter += 1
    end

    counter = 0
    Hike.all.each do |instance|
      instance.accessible = @@hike[:accessible][counter]
      counter += 1
    end
  end

  def all
    @@hike
  end

end

