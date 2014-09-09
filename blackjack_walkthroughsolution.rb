def calculate_total(cards)
	# [['H', '3'], ['S', '4'], ...]
	arr = cards.map{|e| e[1]} #map iterates each array to perform an action and will return new value

	total = 0
	arr.each do |value|
		if value == "A"
			total += 11
		elsif value.to_i == 0 # J, Q, K
			total += 10 
		else
			total += value.to_i # if the value is as per "value.to_i", then we can just add it to total which is 0.
		end
	end

	arr.select{|e| e == "A"}.count.times do #correct for Aces
		total -= 10 if total > 21
	end

	total
end

puts "Welcome to BlackJack!"

suits = ['S', 'H', 'C', 'D']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
deck = suits.product(cards)

deck.shuffle!

#Deal cards
mycards = []
dealercards = []

mycards << deck.pop
dealercards << deck.pop
mycards << deck.pop
dealercards <<deck.pop

dealertotal = calculate_total(dealercards)
mytotal = calculate_total(mycards)

#Show cards
puts "Dealer has: #{dealercards[0]} and #{dealercards[1]}, for a total of #{dealertotal}"
puts "You have: #{mycards[0]} and #{mycards[1]}, for a total of #{mytotal}"
puts ""

#Player Turn

if mytotal == 21
	puts "Congratulations, you hit blackjack, you win!"
	exit
end

while mytotal <21
	puts "What would you like to do? (1) hit (2) stay"
	hit_or_stay = gets.chomp

	if !['1', '2'].include?(hit_or_stay)
		puts "Error: you must enter 1 or 2"
		next
	end

	if hit_or_stay == "2"
		puts "You chose to stay."
		break
	end

	#hit
	new_card = deck.pop
	puts "Dealing card to player: #{new_card}"
	mycards << new_card
	mytotal = calculate_total(mycards)
	puts "Your total is now: #{mytotal}"

	if mytotal == 21
		puts "Congratulations, you hit blackjack! You Win!"
		exit
	elsif mytotal >21
		puts "Sorry, it looks like you busted!"
		exit
	end
end

# Dealer turn

if dealertotal == 21
	puts "Sorry, dealer hit blackjack. You lose."
	exit
end

while dealertotal < 17
	#hit
	new_card = deck.pop
	puts "Dealing new card for dealer: #{new_card}"
	dealercards << new_card
	dealertotal = calculate_total(dealercards)
	puts "dealer total is now: #{dealertotal}"

	if dealertotal == 21
		puts "Sorry, the dealer hit blackjack. You lose."
		exit
	elsif dealertotal > 21
		puts "Congratulations, dealer busted! You win."
		exit
	end
end

# Compare hands

puts "Dealer's cards: "
dealercards.each do |card|
	puts "=> #{card}"
end
puts "Player's cards: "
mycards.each do |card|
	puts "=> #{card}"
end
puts ""

if dealer total > mytotal
	puts "Sorry, dealer wins."
elsif dealertotal < mytotal
	puts "Congratulations, player wins!"
else
	puts "It's a tie!"
end

exit











