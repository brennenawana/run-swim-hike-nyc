require 'pry'
require 'rubygems'
require 'launchy'

class Swim
  attr_accessor :prop_id, :name, :location, :phone, :pools_type, :setting, :size, :accessible, :borough, :lat, :lon
  @@farewell = ["Have a nice day!", "Take care of yourself!", "You'll never regret some good excercise!", "Have fun!", "Thanks for checking us out!", "Keep running, swimming and hiking!", ":)"]
  @@all = []
  @@parks = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.load_borough(cli_input)
    puts " \nPlease choose a setting: \n1.  Indoor \n2.  Outdoor"
    input = gets.strip

    if input.to_s == "1"
      self.all.each do |pool|
        if pool.borough == cli_input && pool.setting == "Indoor"
          @@parks << pool unless @@parks.include?(pool)
        end
      end
      display_borough("#{@@parks[0].borough}", "Indoor") 
    elsif input.to_s == "2"
      self.all.each do |pool|
        if pool.borough == cli_input && pool.setting == "Outdoor"
          @@parks << pool unless @@parks.include?(pool)
        end
      end
      display_borough("#{@@parks[0].borough}", "Outdoor")
    elsif input == "exit"
      quit
    else
      clear
      puts " \n--------------------------------------\nPlease choose a number from the menu:\n--------------------------------------"
      load_borough(cli_input)
    end
  end

  def self.display_borough(borough, setting)
    spinny
    index = 0
    puts " \nHere are the #{setting} Swimming Pools in #{borough}: \n "
    spinny
    @@parks.each do |pool|
      if pool.borough == borough && pool.setting == setting
        puts "#{index+1}. #{pool.name} - #{pool.location}"
        index += 1
        sleep(0.04)
      end
    end
    spinny
    puts " \nSelect a number for more information:"
    spinny
    input = gets.strip
    if input.to_i != 0 && input.to_i <= index
      parks(input)
    elsif input == "exit"
      quit
    else
      clear
      puts " \n--------------------------------------\nPlease choose a number from the menu:\n--------------------------------------"
      display_borough(borough, setting)
    end
  end


  def self.parks(cli_input)
    clear
    display = @@parks[cli_input.to_i-1]
    puts " \n#{display.name}: \n \nBorough:  #{display.borough} \nLocation:  #{display.location} \nPhone:  #{display.phone} \nPool Type:  #{display.pools_type} \nSetting:  #{display.setting} \nSize:  #{display.size} \nWheelchair Accessible:  #{display.accessible}"
    puts " \nOptions:\n'open' to display in Google Maps\n'back' to see search results in #{display.borough}\n'reset' to return to main menu"
    input = gets.strip
    if input == "open"
      Launchy.open("https://www.google.com/maps/place/#{display.name}/@#{display.lat},#{display.lon},18z")
      self.parks(cli_input)
    elsif input == "back"
      clear
      display_borough("#{display.borough}", "#{display.setting}")
    elsif input == "reset"
      reset
    elsif input == "exit"
      quit
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

  def self.quit
    puts " \n"
    abort("#{@@farewell.sample} \n ")
  end

           
end