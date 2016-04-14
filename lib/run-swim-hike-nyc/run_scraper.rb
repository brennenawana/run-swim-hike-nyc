
class RunScraper
  attr_accessor :names, :prop_id, :size, :location, :boroughs, :lat, :lon, :track_type
  @@run = {}

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

    names.each_with_index do |name, index|
      run = Run.new(name.text)
      run.prop_id = prop_id[index].text
      run.size = size[index].text
      run.location = location[index].text
      run.track_type = track_type[index].text
      run.lat = lat[index].text
      run.lon = lon[index].text
    end
  end
    


  def all
    @@run
  end

end



