require 'net/http'
require 'uri'
require_relative 'StrRandomizer.rb'


99.times do
  sr= StrRandomizer.new 

  postData = Net::HTTP.post_form(URI.parse('http://localhost:3000/clients/create'),
			{'company_name'=> sr.company_name,
			'contact_fname'=> sr.fname,
			'contact_lname'=> sr.lname,
			'address_1'=> sr.address,
			'address_2'=>'',
			'city'=>'NY',
			'state'=>'NY',
			'phone'=>'1212-555-5555',
			'zip_code'=>'10005',
			'website'=> sr.website_url })

  puts postData.body

end

