require 'pry'

class Run
  attr_accessor :borough, :name, :prop_id, :size, :location, :lat, :lon
  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end

  def borough
    if prop_id.start_with?("X")
      @borough = "Bronx"
    elsif prop_id.start_with?("B")
      @borough = "Brooklyn"
    elsif prop_id.start_with?("M")
      @borough = "Manhattan"
    elsif prop_id.start_with?("Q")
      @borough = "Queens"
    elsif prop_id.start_with?("R")
      @borough = "Staten Island"
    end
  end
        
        
        
end