class SwimScraper

  attr_accessor :prop_id, :names, :location, :phone, :pools_type, :setting, :size, :accessible, :borough, :lat, :lon
  @@swim = {}

  def initialize
    @prop_id = []
    @names = []
    @location = []
    @phone = []
    @pools_type = []
    @setting = []
    @size = []
    @accessible = []
    @lat = []
    @lon = []
    @borough = []
  end

  def call
    collect_and_create
  end

  def collect_and_create
    xml = open("http://www.nycgovparks.org/bigapps/DPR_Pools_001.xml")
    doc = Nokogiri::HTML(xml)
    facilities = doc.xpath("//facility")
    prop_id = facilities.xpath("//prop_id")
    names = facilities.xpath("//name")
    location = facilities.xpath("//location")
    phone = facilities.xpath("//phone")
    pools_type = facilities.xpath("//pools_type")
    setting = facilities.xpath("//setting")
    size = facilities.xpath("//size")
    accessible = facilities.xpath("//accessible")
    lat = facilities.xpath("//lat")
    lon = facilities.xpath("//lon")

    prop_id.each do |id|
      @prop_id << id.text.to_s
      @@swim[:prop_id] = @prop_id
    end

    names.each do |name|
      @names << name.text.to_s
      @@swim[:names] = @names
    end

    location.each do |location|
      @location << location.text.to_s
      @@swim[:location] = @location
    end

    phone.each do |phone|
      @phone << phone.text.to_s
      @@swim[:phone] = @phone
    end

    pools_type.each do |pools_type|
      @pools_type << pools_type.text.to_s
      @@swim[:pools_type] = @pools_type
    end

    setting.each do |setting|
      @setting << setting.text.to_s
      @@swim[:setting] = @setting
    end

    size.each do |size|
      @size << size.text.to_s
      @@swim[:size] = @size
    end
    
    accessible.each do |accessible|
      @accessible << accessible.text.to_s
      @@swim[:accessible] = @accessible
    end

    lat.each do |lat|
      @lat << lat.text.to_s
      @@swim[:lat] = @lat
    end

    lon.each do |lon|
      @lon << lon.text.to_s
      @@swim[:lon] = @lon
    end

    @@swim[:names].each do |name|
      temp = Swim.new(name)
    end

    counter = 0
    Swim.all.each do |instance|
      instance.prop_id = @@swim[:prop_id][counter]
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
    Swim.all.each do |instance|
      instance.location = @@swim[:location][counter]
      counter += 1
    end

    counter = 0
    Swim.all.each do |instance|
      instance.phone = @@swim[:phone][counter]
      counter += 1
    end

    counter = 0
    Swim.all.each do |instance|
      instance.pools_type = @@swim[:pools_type][counter]
      counter += 1
    end

    counter = 0
    Swim.all.each do |instance|
      instance.setting = @@swim[:setting][counter]
      counter += 1
    end

    counter = 0
    Swim.all.each do |instance|
      instance.size = @@swim[:size][counter]
      counter += 1
    end

    counter = 0
    Swim.all.each do |instance|
      instance.accessible = @@swim[:accessible][counter]
      counter += 1
    end

    counter = 0
    Swim.all.each do |instance|
      instance.lat = @@swim[:lat][counter]
      counter += 1
    end

    counter = 0
    Swim.all.each do |instance|
      instance.lon = @@swim[:lon][counter]
      counter += 1
    end
  end
    

  def all
    @@swim
  end

end

