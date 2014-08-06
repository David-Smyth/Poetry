FactoryGirl.define do
	factory :user do
		name     "John Glenn"
		email    "Astronaut@Freedom7.nasa.gov"
		password "321A-OK"
		password_confirmation "321A-OK"
	end
end