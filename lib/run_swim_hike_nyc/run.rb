require 'pry'

class Run
  attr_accessor :borough, :name, :prop_id, :size, :location, :lat, :lon
  @@all = []

  def initialize(name)
    @name = name
    @prop_id = prop_id
    @@all << self

  end

  def self.all
    @@all
  end
end