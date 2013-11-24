require 'time'

puts "Amount due: "
amount_due = gets.chomp
if amount_due.match(/\A\d+(\.\d{0,2})?\z/) == nil
  puts "WARNING: Invalid currency. Exiting."
  abort
end

puts "Amount tendered: "
amount_tendered = gets.chomp
if amount_tendered.match(/\A\d+(\.\d{0,2})?\z/) == nil
  puts "WARNING: Invalid currency. Exiting."
  abort
end

t = Time.now

customer_change = (amount_tendered.to_f - amount_due.to_f).round(2)

if amount_due.to_f > amount_tendered.to_f
  puts "WARNING: Customer  still owes $#{customer_change.abs}. Exiting."
else
  puts "=== Thanks! ==="
  puts "Your change is $#{customer_change}"
  puts ""
  puts "Your order was processed at #{t.strftime("%m/%d/%Y at %I:%M%P")}"
  puts "====="
end
