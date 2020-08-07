namespace :db do
	task :populate => :environment do
		require 'faker'

		[Micropost, User].each(&:delete_all)

		50.times do
			user = User.create(name: Faker::Name.name,
							   email: Faker::Internet.email,
							   password: "password")
			user.save!
			if user.persisted?
				rand(1..10).times do
					user.microposts.create(content: [Faker::Quotes::Shakespeare.hamlet_quote, 
									 			 	Faker::Quotes::Shakespeare.as_you_like_it_quote,
									 			 	Faker::Quotes::Shakespeare.king_richard_iii_quote, 
									 			 	Faker::Quotes::Shakespeare.romeo_and_juliet_quote])
				end
			end
		end
	end
end