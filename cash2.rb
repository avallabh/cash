require 'time'
# require 'active_support/core_ext/enumerable.rb' <-- just the sum module
# require 'active_support/all'
# Lets you sum arrays with: array.sum
# http://edgeguides.rubyonrails.org/active_support_core_extensions.html

amount_due = 0
subtotal = []

while true
  puts "What is the sale price? Type 'done' when finished"
  input = gets.chomp
  if input == 'done'
    puts "Here are your item prices:"
    puts subtotal.each{|x| x }
    break
  end
  if input.match(/\A\d+(\.\d{0,2})?\z/) == nil
    puts "WARNING: Invalid currency."
    next
  end
  subtotal << input.to_f
  amount_due += input.to_f
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
