require 'time'
require 'csv'

gross = []
cost = []
relevant = []
sales = IO.read('sales.csv')
sales = CSV.parse("#{sales}")
items = []
x = 1
y = sales.length - 1

while true
  puts "Welcome to the Reporting Section"
  print "Enter a date (YYYY-MM-DD): "
  input = gets.chomp
  if input.match(/^\d{4}(-)\d{2}(-)\d{2}/) == nil
    puts "Please enter a valid format (YYYY-MM-DD)."
  elsif Time.parse(input) > Time.now
    puts "Please enter a valid date not in the future."
  else
    for x in (1..y)
      if sales[x][0] == input
        items << sales[x][2].to_i
        gross << sales[x][3].to_i
        cost << sales[x][4].to_i
        relevant << items
      end
    end
    if relevant.empty?
    puts "No sales data found for #{input}"
    else
      puts "\nItems Sold: #{items.inject(0){|sum, x| sum + x}}"
      puts "Gross Sales: $#{gross.inject(0){|sum, y| sum + y}}"
      puts "Net Profit: $#{gross.inject(0){|sum, z| sum + z} - cost.inject(0){|sum, z| sum + z}}"
      puts
    end
    for x in (1..y)
      if sales[x][0] == input
        puts "Date & Time: #{input} @ #{sales[x][1]}"
        puts "Number of items: #{sales[x][2]}"
        puts "Gross: $#{sales[x][3]}"
        puts "Cost: $#{sales[x][4]}"
        puts
      end
    end
    break
  end
end
