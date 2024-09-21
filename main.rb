class PosMachine
  attr_accessor :input_item

  def initialize
    @input_item = input_item
    @item_amount = 0
    @item_name = ""
    @item_store = {
      1 => {
        :name => "banana",
        :price => 12,
        :amout => 10
      },
      2 => {
        :name => "apple",
        :price => 20,
        :amout => 20
      },
      3 => {
        :name => "orange",
        :price => 17,
        :amout => 100
      }
    }
  end

  def show
    puts "Available items:"
    @item_store.each do |id, item|
      puts "ID: #{id}, Name: #{item[:name]}, Price: #{item[:price]}, Available Amount: #{item[:amout]}"
    end
  end

  def checkItem
    puts "Input the item's name or enter 'x' to exit:"
    @item_name = gets.chomp.downcase

    return nil if @item_name == 'x'

    item = @item_store.values.find do |i|
      i[:name].downcase == @item_name
    end

    if item
      puts "#{item[:name]} is available."
      return item
    else
      puts "#{@item_name} is not available."
      return nil
    end
  end

  def checkAmout(item)
    puts "Input the item's amount or enter 'x' to exit:"
    input = gets.chomp.downcase
    return nil if input == 'x'

    @item_amount = input.to_i

    if item[:amout] >= @item_amount
      puts "You can buy it!"
      return true
    else
      puts "Sorry, only #{item[:amout]} #{item[:name]}(s) are available."
      return false
    end
  end

  def buyItem(item)
    puts "Do you want to buy it? (Y/N)"
    buy_cmd = gets.chomp.downcase

    if buy_cmd == "y"
      if item[:amout] >= @item_amount
        puts "You can buy #{@item_amount} #{item[:name]}(s)."
        item[:amout] -= @item_amount
        puts "#{item[:amout]} #{item[:name]}(s) left in stock."
      else
        puts "Sorry, only #{item[:amout]} #{item[:name]}(s) are available."
      end
    else
      puts "Thank you!"
    end
  end
end

# Main program loop
pos_machine = PosMachine.new

loop do
  pos_machine.show
  item = pos_machine.checkItem
  break if item.nil? && pos_machine.input_item == 'x'

  if item
    amount_valid = pos_machine.checkAmout(item)
    break if amount_valid.nil? # Exit if user enters 'x' for the amount

    if amount_valid
      pos_machine.buyItem(item)
    else
      puts "Thank you!"
    end
  else
    puts "Thank you!"
  end
end

puts "Exiting the program. Goodbye!"
