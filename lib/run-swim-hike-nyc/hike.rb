
class Hike
  attr_accessor :prop_id, :name, :location, :park_name, :length, :difficulty, :other_details, :accessible, :borough
  @@farewell = ["Have a nice day!", "Take care of yourself!", "You'll never regret some good excercise!", "Have fun!", "Thanks for checking us out!", "Keep running, swimming and hiking!", ":)"]
  @@all = []
  @@parks = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end

  def self.parks
    @@parks
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

####### HIKE LOGIC ######

  def self.load_borough(cli_input)
    self.all.each do |hike|
      if hike.borough == cli_input
        self.parks << hike unless self.parks.include?(hike)
      end
    end
    display_borough("#{self.parks[0].borough}")
  end

  def self.display_borough(borough)
    spinny
    index = 0
    puts " \nHere are the Hiking Paths in #{borough}: \n "
    spinny
    self.parks.each do |hike|
      if hike.borough == borough
        self.parks << hike unless self.parks.include?(hike)
        puts "#{index+1}. #{hike.name} - #{hike.location}"
        index += 1
        sleep(0.04)
      end
    end
    spinny
    puts " \nSelect a number for more information:"
    spinny
    input = gets.strip
    if input.to_i != 0 && input.to_i <= self.parks.size
      park_select(input)
    elsif input == "exit"
      quit
    elsif input == "reset"
      reset
    else
      clear
      puts " \n--------------------------------------\nPlease choose a number from the menu:\n--------------------------------------"
      display_borough("#{self.park_select[0].borough}")
    end
  end

  def self.park_select(cli_input)
    clear
    display = @@parks[cli_input.to_i-1]
    puts " \n#{display.name}: \n \nBorough:  #{display.borough} \nLocation:  #{display.location} \nPark Name:  #{display.park_name} \nLength:  #{display.length} \nDifficulty:  #{display.difficulty} \nOther Details: #{display.other_details} \nWheelchair Accessible: #{display.accessible} "
    puts " \nOptions:\n'open' to display in Google Maps\n'back' to see search results in #{display.borough}\n'reset' to return to main menu"
    input = gets.strip
    if input == "open"
      Launchy.open("https://www.google.com/maps/place/#{display.park_name}")
      self.park_select(cli_input)
    elsif input == "back"
      clear
      display_borough("#{display.borough}")
    elsif input == "reset"
      reset
    elsif input == "exit"
      quit
    else
      park_select(cli_input)
    end
  end
           
end