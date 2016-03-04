require 'pry'

class RunSwimHike::CLI
@@farewell = ["Have a nice day!", "Take care of yourself!", "You'll never regret some good excercise!", "Have fun!", "Thanks for checking us out!", "Keep running, swimming and hiking!", ":)"]

  def initialize
    opening_greeting
  end

  def opening_greeting
    puts " \n*** Welcome to RunSwimHike NYC! ***\n "
    spinny
    first_menu
  end

  def first_menu
    puts "What would you like to do?"
    puts "1. Run\n2. Swim\n3. Hike"
    menu
  end

  def menu
    input = gets.strip
    if input.to_s == "1"
      run_boroughs
    elsif input.to_s == "2"
      swim_boroughs
    elsif input.to_s == "3"
      hike_boroughs
    elsif input == "exit"
      quit
    else
      clear
      puts " \n--------------------------------------\nPlease choose a number from the menu:\n--------------------------------------"
      opening_greeting           
    end
  end

  def quit
    puts " \n"
    abort("#{@@farewell.sample} \n ")
  end

####### RUN #######
  def run_boroughs
    RunScraper.new.call
    run_menu
  end

  def run_menu
    puts " \nWhere would you like to Run?"
    puts " \n1. Bronx\n2. Brooklyn\n3. Manhattan\n4. Queens\n5. Staten Island"
    spinny
    borough = gets.strip
    if borough.to_s == "1"
      run_bronx
    elsif borough.to_s == "2"
      run_brooklyn
    elsif borough.to_s == "3"
      run_manhattan
    elsif borough.to_s == "4"
      run_queens
    elsif borough.to_s == "5"
      run_staten_island
    elsif borough == "exit"
      abort("Have a nice day!") 
    else
      clear
      puts " \n--------------------------------------\nPlease choose a number from the menu:\n--------------------------------------"
      run_menu
    end
  end


  def run_bronx
    puts " \n"
    Run.load_borough("Bronx")
  end

  def run_brooklyn
    puts " \n"
    Run.load_borough("Brooklyn")
  end

  def run_manhattan
    puts " \n"
    Run.load_borough("Manhattan")
  end

  def run_queens
    puts " \n"
    Run.load_borough("Queens")
  end

  def run_staten_island
    puts " \n"
    Run.load_borough("Staten Island")
  end

####### SWIM #######

  def swim_boroughs
    SwimScraper.new.call
    swim_menu
  end

  def swim_menu
    puts " \nWhere would you like to Swim?"
    puts " \n1. Bronx\n2. Brooklyn\n3. Manhattan\n4. Queens\n5. Staten Island"
    spinny
    borough = gets.strip
    if borough.to_s == "1"
      swim_bronx
    elsif borough.to_s == "2"
      swim_brooklyn
    elsif borough.to_s == "3"
      swim_manhattan
    elsif borough.to_s == "4"
      swim_queens
    elsif borough.to_s == "5"
      swim_staten_island
    elsif borough == "exit"
      abort("Have a nice day!") 
    else
      clear
      puts " \n--------------------------------------\nPlease choose a number from the menu:\n--------------------------------------"
      swim_menu
    end
  end


  def swim_bronx
    puts " \n"
    Swim.load_borough("Bronx")
  end

  def swim_brooklyn
    puts " \n"
    Swim.load_borough("Brooklyn")
  end

  def swim_manhattan
    puts " \n"
    Swim.load_borough("Manhattan")
  end

  def swim_queens
    puts " \n"
    Swim.load_borough("Queens")
  end

  def swim_staten_island
    puts " \n"
    Swim.load_borough("Staten Island")
  end

####### EXTRA FEATURES #######
  def clear
    print "\e[2J\e[f"
  end

  def spinny
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