# First, let's find the item with ID 2
item_to_delete = Cart.find_by(id: 1)

# Check if the item exists before attempting to delete it
if item_to_delete
  # If the item exists, delete it
  item_to_delete.destroy
  puts "Item with ID 2 has been deleted successfully."
else
  # If the item doesn't exist, print a message
  puts "Item with ID 2 does not exist."
end
