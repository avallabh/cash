require 'time'
require 'csv'

amount_due = 0
cost_items = 0
bags = {}
gross = []
cost = []
items_array = []
relevant = []
items = IO.read('products.csv')
items = CSV.parse("#{items}")
sales = IO.read('sales.csv')
sales = CSV.parse("#{sales}")
x = 1
items_length = items.length - 1
sales_length = sales.length - 1

puts "Welcome to James' Coffee Emporium!\n"
while true
  puts "Press 1 for Reports (Management Only)"
  puts "Press 2 for Transactions (Customers)"
  print "Input: "
  number = gets.chomp
  if number.match(/\A[1-2]?\z/) == nil
    puts "Please choose 1 or 2"
  elsif number == '1'
    # -------------- MANAGER PROGRAM ----------------
    while true
      puts "Welcome to the Reporting Section"
      print "Enter a date (YYYY-MM-DD): "
      input = gets.chomp
      if input.match(/^\d{4}(-)\d{2}(-)\d{2}/) == nil
        puts "Please enter a valid format (YYYY-MM-DD)."
      elsif Time.parse(input) > Time.now
        puts "Please enter a valid date not in the future."
      else
        for x in (1..sales_length)
          if sales[x][0] == input
            items_array << sales[x][2].to_i
            gross << sales[x][3].to_f
            cost << sales[x][4].to_f
            relevant << items_array
          end
        end
        if relevant.empty?
          puts "No sales data found for #{input}"
        else
          puts "\nItems Sold: #{items_array.inject(0){|sum, x| sum + x}}"
          puts "Gross Sales: $#{gross.inject(0){|sum, y| sum + y}}"
          puts "Net Profit: $#{gross.inject(0){|sum, z| sum + z} - cost.inject(0){|sum, z| sum + z}}"
          puts
        end
        for x in (1..sales_length)
          if sales[x][0] == input
            puts "Date & Time: #{input} @ #{sales[x][1]}"
            puts "Number of items: #{sales[x][2]}"
            puts "Gross: $#{sales[x][3]}"
            puts "Cost: $#{sales[x][4]}"
            puts
          end
        end
      end
      exit
    end
    break
  elsif number == '2'
    # -------------- CUSTOMER PROGRAM ----------------
    puts "0) Complete Sale"
    for x in (items_length)
      puts "#{x}) Add item - #{items[x][0]} - $#{items[x][2]}"
      bags[items[x][0]] = 0
    end

    selection = ""
    until selection == "0"
      print "Make a selection: "
      selection = gets.chomp
      next if selection == "0"
      print "How many bags? "
      quantity = gets.chomp
      each_subtotal = items[selection.to_i][2].to_f * quantity.to_f
      each_cost = items[selection.to_i][3].to_f * quantity.to_f
      amount_due += each_subtotal.to_f
      cost_items += each_cost.to_f
      bags[items[selection.to_i][0]] += quantity.to_f
    end
    # --- END OF TRANSACTION OUTPUT BELOW ---
    puts "=== Sale Complete ==="
    bags.each do |bag, quantity|
      bag_index = 0
      items.each do |item|
        bag_index = items.index(item) if bag == item[0]
      end
      puts "$#{"%.2f" % (quantity * items[bag_index][2].to_f)} - #{quantity} #{bag}" unless quantity == 0
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
      File.open("sales.csv", "a") do |f|
        f.write("#{t.strftime("%Y-%m-%d")},#{t.strftime("%I:%M%P")},#{bags.values.inject(0){|sum, x| sum + x}.to_i},#{amount_due},#{cost_items}\n")
      end
    end
  end
  break
end
