FactoryGirl.define do
	factory :user do
		name "Michael Hartl"
		email "mhartl@example.com"
		password "foobar"
		password_confirmation "foobar"
	end

	sequence(:email) { |n| "person-#{n}@example.com" }
end

