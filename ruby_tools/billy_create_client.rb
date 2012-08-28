require 'net/http'
require 'uri'

# This is just a sample http request.
# TODO: Rewrite this code to make multiple requests with different data
#
postData = Net::HTTP.post_form(URI.parse('http://localhost:3000/clients/create'),
			{'company_name'=>'Test Company',
			'contact_fname'=>'Testing',
			'contact_lname'=>'User',
			'address_1'=>'123 Doe St',
			'address_2'=>'',
			'city'=>'NY',
			'state'=>'NY',
			'phone'=>'1212-555-5555',
			'zip_code'=>'10005',
			'website'=>'testingsite.com'})

puts postData.body
