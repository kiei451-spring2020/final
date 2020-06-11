# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :stores do
  primary_key :id
  String :title
  String :description, text: true
  String :phone
  String :location
end
DB.create_table! :posts do
  primary_key :id
  foreign_key :restaurant_id
  foreign_key :user_id
  Boolean :like
  String :comments, text: true
end
DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
end

# Insert initial (seed) data
store_table = DB.from(:stores)

store_table.insert(title: "MedMen", 
                    description: "One of the best dispensaries in Evanston, with a large selection",
                    phone: "(224) 278-9988",
                    location: "1804 Maple Ave, Evanston, IL 60201")

store_table.insert(title: "Consume", 
                    description: "Modern vibes with friendly staff",
                    phone: "(872) 304-3113",
                    location: "6428 N Milwaukee Ave, Chicago, IL 60631")