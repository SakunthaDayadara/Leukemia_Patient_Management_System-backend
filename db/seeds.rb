# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# List of existing ward numbers
ward_numbers = %w[wd10 wd11 wd15 wd16]

# Creating beds for each ward
ward_numbers.each do |ward_num|
  ward = Ward.find_by(ward_num: ward_num)
  if ward
    40.times do |i|
      bed_id = "#{ward_num}bd#{format('%02d', i + 1)}"
      Bed.create!(
        bed_id: bed_id,
        ward_num: ward.ward_num,
        is_occupied: false,
        patient_id: nil # Assuming beds start as unoccupied
      )
    end
  else
    puts "Warning: Ward #{ward_num} does not exist."
  end
end

puts "Seeding completed!"