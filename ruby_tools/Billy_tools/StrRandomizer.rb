#!/usr/bin/ruby

class StrRandomizer
 
  def initialize 
    @fnames = [ "Patrick", "Geno", "Sam","Alfred","Mario","Luigi","Rocky","Joe" ]
    @lnames = [ "Gonzalez", "Sanchez", "Neira","Santos","Ramirez","Reyes" ]
    @comp_types = [ "Grocery Store", "Tatto Shop", "Auto Parts", "Pharmacy", "Burger Shop"]
     
    @comp_type = @comp_types[rand(@comp_types.size)]
    @fname = @fnames[rand(@fnames.size)]
    @lname = @lnames[rand(@lnames.size)]

    @street_num = []
    rand(1..4).times do 
        num = rand(1..9)
        @street_num.push(num) 
    end 
    
    @street_names = [ "Doe", "Gold", "Fulton", "Main", "Bedford" ] 
    @street_types = [ "Avenue", "Street", "Road", "Boulevard" ]
    
    @street_name = @street_names[rand(@street_names.size)]
    @street_type  = @street_types[rand(@street_types.size)]

  end

  def company_name
    @fname + "'s " + @comp_type
  end

  def website_url
    @fname.downcase + @comp_type.gsub(/\s+/,"").downcase + ".com"
  end

  def fname
    @fname
  end

  def lname
    @lname
  end

  def address
     @street_num.join + " " + @street_name + " " + @street_type 
  end

end
