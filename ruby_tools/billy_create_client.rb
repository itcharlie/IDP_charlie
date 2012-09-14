require 'net/http'
require 'uri'

# This script will create 99 requests with random data to create clients on Billy app

fnames = [ "Patrick", "Geno", "Sam","Alfred","Mario","Luigi","Rocky","Joe" ]
lnames = [ "Gonzalez", "Sanchez", "Neira","Santos","Ramirez","Reyes" ]
comp_types = [ "Grocery Store", "Tatto Shop", "Auto Parts", "Pharmacy", "Burger Shop"]


99.times do
comp_type = comp_types[rand(comp_types.size)]
fname = fnames[rand(fnames.size)] 
lname = lnames[rand(lnames.size)] 
company_name = fname + "'s " + comp_type
 
postData = Net::HTTP.post_form(URI.parse('http://localhost:3000/clients/create'),
			{'company_name'=> company_name,
			'contact_fname'=> fname,
			'contact_lname'=> lname,
			'address_1'=>'123 Doe St',
			'address_2'=>'',
			'city'=>'NY',
			'state'=>'NY',
			'phone'=>'1212-555-5555',
			'zip_code'=>'10005',
			'website'=> fname.downcase + comp_type.gsub(/\s+/,"").downcase + ".com"})

puts postData.body

end

