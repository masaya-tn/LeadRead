puts 'Start inserting seed "outputs" ...'
User.all.each do |user|
  output = user.outputs.create(title: Faker::Games::Pokemon.name, body: 'a', book_title: '本')
  puts "output#{output.id} has created!"
end
