# Definitions and arrays
# Deal cards
# Show cards
# Player Turn
# Dealer Turn
# Compare
# Winer announced

# Bonus
# 1. Save the player's name, and use it throughout the app. (Unresolved)
# 2. Ask the player if he wants to play again, rather than just exiting. (Done)
# 3. Save not just the card value, but also the suit. (Done)
# 4. Use multiple decks to prevent against card counting players. (Done)


def username
  puts "What is your name? Type it below"
  name = gets.chomp
  puts "Hello, #{name}"
  play
end

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

def init_game(mycards, dealercards)
  suits = ['Spades', 'Hearts', 'Clubs', 'Diamonds']
  cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']
  deck = suits.product(cards)
  rand(5).times { deck << suits.product(cards)}
  deck.shuffle!

  2.times do
    mycards << deck.pop
    dealercards <<deck.pop
  end
  deck
end

def play
  #Deal cards
  mycards = []
  dealercards = []
  deck = init_game(mycards, dealercards)
  dealertotal = calculate_total(dealercards)
  mytotal = calculate_total(mycards)

  #Show cards
  puts "Dealer has: #{dealercards[0]} and #{dealercards[1]}, for a total of #{dealertotal}"
  puts "You have: #{mycards[0]} and #{mycards[1]}, for a total of #{mytotal}"
  puts ""

  #Player Turn

  if mytotal == 21
    puts "Congratulations, you hit blackjack, you win!"
    cont
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
    puts "Your total is now: #{mytotal}, your cards are: #{mycards}"

    if mytotal == 21
      puts "Congratulations, you hit blackjack! You Win!"
      cont
    elsif mytotal >21
      puts "Sorry, it looks like you busted!"
      cont
    end
  end

  # Dealer turn

  if dealertotal == 21
    puts "Sorry, dealer hit blackjack. You lose."
    cont
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
      cont
    elsif dealertotal > 21
      puts "Congratulations, dealer busted! You win."
      cont
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

  if dealertotal > mytotal
    puts "Sorry, dealer wins."
    cont
  elsif dealertotal < mytotal
    puts "Congratulations, player wins!"
    cont
  else
    puts "It's a tie!"
    cont
  end
end

def cont
puts "#{name}, would you like to continue? (Y/N) "
continue = gets.chomp.upcase
  if continue == "Y"
  play
  elsif continue == "N"
  puts "Thank you for your time and money!"
  exit  
  else continue != "Y"
  puts "I don't understand, would you like to try again?"
  cont
  end
end

puts "Welcome to BlackJack!"
username
