require 'faraday'
require 'JSON'
require 'yaml'
require 'io/console'
require 'open-uri'

class String
  def pretty
    JSON.parse(self).to_yaml
  end  
end

def puts string
  $stdout.write(string)
  $stdout.write("\n")
end

conn = Faraday.new(:url => 'http://localhost:3000') do |faraday|
  faraday.request  :url_encoded             # form-encode POST params
 # faraday.response :logger                  # log requests to STDOUT
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

puts "Creating First User"
conn.post("api/users", :username => "First User")

puts "Creating Second user" 
conn.post("api/users", :username => "Second User")

puts "Here are our users"
users = JSON.parse(conn.get("api/users").body)
puts users.to_yaml

puts "Creating First Book"
conn.post("api/books", :title => "Book One")

puts "Creating Second Book" 
conn.post("api/books", :title => "Book Two")

puts 'Here our our books'
books = JSON.parse(conn.get("api/books").body)
puts books.to_yaml

puts "Next users get books. Press space to contiue.."
sleep 1 while $stdin.getch != " "

puts "Users get books"
users.each do |user|
  books.each do |book|
   conn.post("api/users/#{user["id"]}/books", :book_id => book["id"])
 end
end

users.each do |user|
  puts "User: #{user["username"]} books"  
  puts conn.get("api/users/#{user["id"]}/books").body.pretty
end

puts "Next users tag users and books. Press space to contiue.."
sleep 1 while $stdin.getch != " "

users.each do |user|
  books.each do |book|
     if( book["id"] == user["id"]) 
       conn.post("api/users/#{user["id"]}/books/#{book["id"]}/tag", :tag => "Tag from #{user["username"]}")
     end
  end
  users.each do |other_user|
    unless other_user == user
      conn.post("api/users/#{user["id"]}/users/#{other_user["id"]}/tag", :tag => "Tag from #{user["username"]}")
    end
  end
end

users.each do |user|
   puts "User: #{user["username"]} tags"
   puts conn.get("api/users/#{user["id"]}/tags").body.pretty
end

books.each do |book|
  puts "Book: #{book["title"]} tags"
  puts  conn.get("api/books/#{book["id"]}/tags").body.pretty
end

puts "Next find things with tags press space to contine"
sleep 1 while $stdin.getch != " "

users.each do |user|
  tag =  "Tag from #{user["username"]}"
  puts "Getting books tagged with '#{tag}'"
  puts conn.get("api/books/tagged_with/#{URI.encode(tag)}").body.pretty
  
  puts "Getting users tagged with '#{tag}'"
  puts conn.get("api/users/tagged_with/#{URI.encode(tag)}").body.pretty
end

 






 

