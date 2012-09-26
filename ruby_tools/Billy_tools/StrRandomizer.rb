#!/usr/bin/ruby

class StrRandomizer
 
  def initialize 
    @fnames = [ "Patrick", "Geno", "Sam","Alfred","Mario","Luigi","Rocky","Joe" ]
    @lnames = [ "Gonzalez", "Sanchez", "Neira","Santos","Ramirez","Reyes" ]
    @comp_types = [ "Grocery Store", "Tatto Shop", "Auto Parts", "Pharmacy", "Burger Shop"]
    
    @comp_type = @comp_types[rand(@comp_types.size)]
    @fname = @fnames[rand(@fnames.size)]
    @lname = @lnames[rand(@lnames.size)]
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



end
