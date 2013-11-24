=begin

USER STORIES

1) As a cashier
   I want to display a menu
   So that I can make checkout easier
2) As a cashier
   I want to prompted to choose items from menu
   So I can speed up checkout
3) As a cashier
   I want to prompted to choose quantities from menu
   So I can speed up checkout
4) As a cashier
   I want to display subtotal and quantities
   So the customer has an itemized list
5) As a cashier
   I want to have an option to exit/finish
   So the transaction is finalized

ACCEPTANCE CRITERIA

* Menu of prices and items displayed
* User selections an item number from menu
* User selections quantity of item
* Running total is displayed
* User repeats for each different item
* User selects last option to finish
* Itemized list of subtotal per item, and item quantity, is displayed
* (same as previous programs from here on out)

=end

require 'time'

amount_due = 0
subtotal_light = 0
subtotal_medium = 0
subtotal_bold = 0
light = []
medium = []
bold = []
bags = { "1" => {:price => 5.00} , "2" => {:price => 7.50}, "3" => {:price => 9.75} }

puts "Welcome to James' Coffee Emporium!\n"
puts "1) Add item - $5.00 - Light Bag"
puts "2) Add item - $7.50 - Medium Bag"
puts "3) Add item - $9.75 - Bold Bag"
puts "4) Complete Sale"

while true
   puts "Make a selection: "
   selection = gets.chomp
   if selection == "1"
      puts "How many bags?"
      quantity = gets.chomp
      price = bags[selection][:price]
      light << quantity.to_i
      light_quantity = light.inject(0){|sum, x| sum + x}
      subtotal_light = (light_quantity.to_f * price)
    elsif selection == "2"
      puts "How many bags?"
      quantity = gets.chomp
      price = bags[selection][:price]
      medium << quantity.to_i
      medium_quantity = medium.inject(0){|sum, x| sum + x}
      subtotal_medium = (medium_quantity.to_f * price)
    elsif selection == "3"
      puts "How many bags?"
      quantity = gets.chomp
      price = bags[selection][:price]
      bold << quantity.to_i
      bold_quantity = bold.inject(0){|sum, x| sum + x}
      subtotal_bold = (bold_quantity.to_f * price)
    elsif selection == "4"
      puts "=== Sale Complete ==="
      puts "#{subtotal_light} - #{light_quantity} Light"
      puts "#{subtotal_medium} - #{medium_quantity} Medium"
      puts "#{subtotal_bold} - #{bold_quantity} Bold"
      break
   elsif selection.match(/\A[1-4]?\z/) == nil
      puts "Invalid selection"
      next
   end
  amount_due = subtotal_light.to_f + subtotal_medium.to_f + subtotal_bold.to_f
  puts "Your subtotal is $#{amount_due}."
end

puts "The total amount due is: $#{amount_due}"
puts "What is the amount tendered? "
amount_tendered = gets.chomp

if amount_tendered.match(/\A\d+(\.\d{0,2})?\z/) == nil
  puts "WARNING: Invalid currency. Exiting."
  abort
end

t = Time.now
customer_change = (amount_tendered.to_f - amount_due.to_f).round(2)

if amount_due.to_f > amount_tendered.to_f
  puts "WARNING: Customer still owes $#{customer_change.abs}. Exiting."
else
  puts "=== Thanks! ==="
  puts "Your change is $#{customer_change}"
  puts ""
  puts "Your order was processed on #{t.strftime("%m/%d/%Y at %I:%M%P")}"
  puts "====="
end
