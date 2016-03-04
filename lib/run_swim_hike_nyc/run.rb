require 'pry'
require 'rubygems'
require 'launchy'

class Run
  attr_accessor :borough, :name, :prop_id, :size, :track_type, :location, :lat, :lon
  @@all = []
  @@parks = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.names
    self.all.each_with_index do |x, i|
      puts "#{i+1}: #{x.name}"
    end
  end

  def self.load_borough(cli_input)
    self.all.each do |track|
      if track.borough == cli_input
        @@parks << track unless @@parks.include?(track)
      end
    end
    display_borough("#{@@parks[0].borough}")
  end

  def self.display_borough(borough)
    spinny
    index = 0
    puts " \nHere are the Running Tracks in #{borough}: \n "
    spinny
    @@parks.each do |track|
      if track.borough == borough
        @@parks << track unless @@parks.include?(track)
        puts "#{index+1}. #{track.name} - #{track.location}"
        index += 1
        sleep(0.04)
      end
    end
    spinny
    puts " \nSelect a number for more information:"
    spinny
    input = gets.strip
    if input.to_i != 0 && input.to_i <= @@parks.size
      parks(input)
    elsif input == "exit"
      abort("Have a nice day!")
    else
      clear
      puts " \n--------------------------------------\nPlease choose a number from the menu:\n--------------------------------------"
      display_borough("#{@@parks[0].borough}")
    end
  end


  def self.parks(cli_input)
    clear
    display = @@parks[cli_input.to_i-1]
    puts " \n#{display.name}: \n \nBorough:  #{display.borough} \nLocation:  #{display.location} \nSize:  #{display.size} mile(s)\nRunning Track Type:  #{display.track_type} "
    puts " \nOptions:\n'open' to display in Google Maps\n'back' to see search results in #{display.borough}\n'reset' to return to main menu"
    input = gets.strip
    if input == "open"
      Launchy.open("https://www.google.com/maps/place/#{display.name}/@#{display.lat},#{display.lon},18z")
      self.parks(cli_input)
    elsif input == "back"
      clear
      display_borough("#{display.borough}")
    elsif input == "reset"
      reset
    elsif input == "exit"
      abort("Have a nice day!")
    else
      parks(cli_input)
    end
  end
  
  def self.all
    @@all
  end

  def self.reset
    clear
    @@all = []
    @@parks = []
    RunSwimHike::CLI.new
  end

  def self.park_list
    @@parks
  end

  def self.clear
    print "\e[2J\e[f"
  end

  def self.spinny
    n=0
    a=["-","\\","|","/"].cycle do |a|
      print a
      print "\b"
      n+=1
      sleep 0.1
      break if (n % 6).zero?
    end
  end

           
end