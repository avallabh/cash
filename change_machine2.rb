print "Amount due: "
due = gets.chomp
print "Amount tendered: "
tendered = gets.chomp

if due.match(/\A\d+(\.\d{0,2})?\z/) == nil || tendered.match(/\A\d+(\.\d{0,2})?\z/) == nil
  puts "WARNING: Invalid currency. Exiting."
  abort
end

change = (tendered.to_f - due.to_f).round(2)
puts "If the customer pays $#{tendered.to_f}, the total change due is $#{change}"
if change == 0
  exit
else
  puts "\nYou should issue: "
  change *= 100
  dollars = (change - (change % 100)) / 100
  change -= dollars*100
  quarters = (change - (change % 25)) / 25
  change -= quarters*25
  dimes = (change - (change % 10)) / 10
  change -= dimes*10
  nickels = (change - (change % 5)) / 5
  change -= nickels*5
  pennies = (change - (change % 1) / 1) # Yes I divided by one
  puts "#{dollars.to_i} dollars"
  puts "#{quarters.to_i} quarters"
  puts "#{dimes.to_i} dimes"
  puts "#{nickels.to_i} nickels"
  puts "#{pennies.to_i} pennies"
end
