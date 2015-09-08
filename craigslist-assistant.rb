require './CraigslistAssistant.rb'

start_time = Time.now
puts "Starting Script..."

# Assistant gets list of links and shows them in
# browser one-by-one, letting me choose Y or N
# and writes emails an output file
links_csv_file_path = "links-eng.csv"
output_file_path = "emails-eng.csv"

cl_assistant = CraigslistAssistant.new( { links_csv_file: links_csv_file_path,
																					output_csv_file: output_file_path })
cl_assistant.present_links

say_string = "All Done!"
`say "#{say_string}"`
puts "Script Complete!"
puts "Time elapsed: #{Time.now - start_time} seconds"
