# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# List of existing ward numbers with their patient genders
wards = {
  "wd10" => "male",
  "wd11" => "male",
  "wd15" => "female",
  "wd16" => "female"
}

# Creating wards
wards.each do |ward_num, patient_gender|
  Ward.find_or_create_by!(ward_num: ward_num) do |ward|
    ward.patient_gender = patient_gender
    ward.created_at = Time.now
    ward.updated_at = Time.now
  end
end

# Creating beds for each ward
wards.keys.each do |ward_num|
  ward = Ward.find_by(ward_num: ward_num)
  if ward
    40.times do |i|
      bed_id = "#{ward_num}bd#{format('%02d', i + 1)}"
      Bed.find_or_create_by!(
        bed_id: bed_id,
        ward_num: ward.ward_num,
        is_occupied: false,
        patient_id: nil # Assuming beds start as unoccupied
      ) do |bed|
        bed.created_at = Time.now
        bed.updated_at = Time.now
      end
    end
  else
    puts "Warning: Ward #{ward_num} does not exist."
  end
end

puts "Seeding completed!"
