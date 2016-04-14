
class RunScraper
  attr_accessor :names, :prop_id, :size, :location, :boroughs, :lat, :lon, :track_type
  @@run = {}

  def initialize
    @names = []
    @prop_id = []
    @size = []
    @location = []
    @track_type = []
    @lat = []
    @lon = []
    @boroughs = {}
  end

  def call
    collect_and_create
  end

  def collect_and_create
    xml = open("http://www.nycgovparks.org/bigapps/DPR_RunningTracks_001.xml")
    doc = Nokogiri::HTML(xml)
    facilities = doc.xpath("//facility")
    names = facilities.xpath("//name")
    prop_id = facilities.xpath("//prop_id")
    size = facilities.xpath("//size")
    location = facilities.xpath("//location")
    track_type = facilities.xpath("//runningtracks_type")
    lat = facilities.xpath("//lat")
    lon = facilities.xpath("//lon")


    names.each do |name|
      @names << name.text.to_s
      @@run[:names] = @names
    end

    prop_id.each do |id|
      @prop_id << id.text.to_s
      @@run[:prop_id] = @prop_id
    end

    size.each do |size|
      @size << size.text.to_s
      @@run[:size] = @size
    end

    location.each do |location|
      @location << location.text.to_s
      @@run[:location] = @location
    end

    track_type.each do |track_type|
      @track_type << track_type.text.to_s
      @@run[:track_type] = @track_type
    end

    lat.each do |lat|
      @lat << lat.text.to_s
      @@run[:lat] = @lat
    end

    lon.each do |lon|
      @lon << lon.text.to_s
      @@run[:lon] = @lon
    end

    @@run[:names].each do |name|
      Run.new(name)
    end

    counter = 0
    Run.all.each do |instance|
      instance.prop_id = @@run[:prop_id][counter]
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
    Run.all.each do |instance|
      instance.size = @@run[:size][counter]
      counter += 1
    end

    counter = 0
    Run.all.each do |instance|
      instance.location = @@run[:location][counter]
      counter += 1
    end
 

    counter = 0
    Run.all.each do |instance|
      instance.track_type = @@run[:track_type][counter]
      counter += 1
    end

    counter = 0
    Run.all.each do |instance|
      instance.lat = @@run[:lat][counter]
      counter += 1
    end

    counter = 0
    Run.all.each do |instance|
      instance.lon = @@run[:lon][counter]
      counter += 1
    end
  end
    


  def all
    @@run
  end

end


  # def index_boroughs
  #   bronx = []
  #   brooklyn = []
  #   manhattan = []
  #   queens = []
  #   staten_island = []

  #   hash = Hash[@prop_id.map.with_index.to_a]
  #   hash.each do |prop_id, array_position|
  #     if prop_id.start_with?("X")
  #       bronx << array_position
  #     elsif prop_id.start_with?("B")
  #       brooklyn << array_position
  #     elsif prop_id.start_with?("M")
  #       manhattan << array_position
  #     elsif prop_id.start_with?("Q")
  #       queens << array_position
  #     elsif prop_id.start_with?("R")
  #       staten_island << array_position          
  #     end
  #   end
  #   @boroughs[:bronx] = bronx
  #   @boroughs[:brooklyn] = brooklyn
  #   @boroughs[:manhattan] = manhattan
  #   @boroughs[:queens] = queens
  #   @boroughs[:staten_island] = staten_island
  # end

  # def bronx
  #   @boroughs[:bronx].each_with_index do |array_position, i|
  #     puts "#{i+1}: #{@names[array_position]}"
  #   end
  # end

  # def brooklyn
  #   @boroughs[:brooklyn].each_with_index do |array_position, i|
  #     puts "#{i+1}: #{@names[array_position]}"
  #   end
  # end

  # def manhattan
  #   @boroughs[:manhattan].each_with_index do |array_position, i|
  #     puts "#{i+1}: #{@names[array_position]}"
  #   end
  # end

  # def queens
  #   @boroughs[:queens].each_with_index do |array_position, i|
  #     puts "#{i+1}: #{@names[array_position]}"
  #   end
  # end

  # def staten_island
  #   @boroughs[:staten_island].each_with_index do |array_position, i|
  #     puts "#{i+1}: #{@names[array_position]}"
  #   end
  # end


  # def list_names
  #   @names.each_with_index do |name, i|
  #     puts "#{i+1}: #{name}"
  #   end
  # end


