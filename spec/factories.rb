FactoryGirl.define do
	factory :user do
		name "Michael Hartl"
		email "mhartl@example.com"
		password "foobar"
		password_confirmation "foobar"

		factory :user_with_micropost do
			after_create do |user|
				create(:micropost, user: user)
			end
		end 
	end

	sequence(:email) { |n| "person-#{n}@example.com" }

	factory :micropost do
		content "Foo bar"
		association :user
	end
end

