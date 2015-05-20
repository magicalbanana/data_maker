# This was made so that I could easily transfer or transform a dataset that was in yaml format
# that had all the region data for china. The cities.yml file was taken from china_regions gem.
#
# require 'hashie'
#
# module Modulator
#   def self.create_province_chinese
#     results = []
#     china_regions = YAML::load(File.open('lib/data_maker/data/cities.yml'))
#     china_regions.each do |key, value|
#       results << [value["name_en"], key].join(": ")
#     end
#
#     file = "provinces_chinese"
#     File.open(file, "w") { |f| f.write results.join("\n") }
#
#     results
#   end
#
#   def self.create_provinces
#     results = []
#     china_regions = YAML::load(File.open('lib/data_maker/data/cities.yml'))
#     china_regions.extend Hashie::Extensions::DeepFind
#     china_cities = china_regions.deep_find_all("name_en")
#     china_cities.each do |key, value|
#       results << key
#     end
#
#     file = "provinces"
#     File.open(file, "w") { |f| f.write results.join("\n") }
#
#     results
#   end
#
#   def self.create_cities_chinese
#     results = []
#     china_regions = YAML::load(File.open('lib/data_maker/data/cities.yml'))
#     china_regions.extend Hashie::Extensions::DeepFind
#     china_cities = china_regions.deep_find_all("cities")
#     china_cities.each do |city|
#       city.each do |key, value|
#         value.extend Hashie::Extensions::DeepFind
#         results << [value["name_en"], key].join(": ")
#       end
#     end
#
#     file = "cities_chinese"
#     File.open(file, "w") { |f| f.write results.join("\n") }
#
#     results
#   end
#
#   def self.create_cities
#     results = []
#     china_regions = YAML::load(File.open('lib/data_maker/data/cities.yml'))
#     china_regions.extend Hashie::Extensions::DeepFind
#     china_cities = china_regions.deep_find_all("cities")
#     china_cities.each do |city|
#       city.each do |key, value|
#         value.extend Hashie::Extensions::DeepFind
#         results << value["name_en"]
#       end
#     end
#
#     file = "cities"
#     File.open(file, "w") { |f| f.write results.join("\n") }
#
#     results
#   end
#
#   def self.create_districts_chinese
#     results = []
#     china_regions = YAML::load(File.open('lib/data_maker/data/cities.yml'))
#     china_regions.extend Hashie::Extensions::DeepFind
#     china_cities = china_regions.deep_find_all("cities")
#     china_cities.each do |city|
#       city.each do |key, value|
#         value.extend Hashie::Extensions::DeepFind
#         value.deep_find("districts").each do |k, v|
#           results << [v["name_en"], k].join(": ")
#         end
#       end
#     end
#
#     file = "districts_chinese"
#     File.open(file, "w") { |f| f.write results.join("\n") }
#
#     results
#   end
#
#   def self.create_districts
#     results = []
#     china_regions = YAML::load(File.open('lib/data_maker/data/cities.yml'))
#     china_regions.extend Hashie::Extensions::DeepFind
#     china_cities = china_regions.deep_find_all("cities")
#     china_cities.each do |city|
#       city.each do |key, value|
#         value.extend Hashie::Extensions::DeepFind
#         value.deep_find("districts").each do |k, v|
#           results << v["name_en"]
#         end
#       end
#     end
#
#     file = "districts"
#     File.open(file, "w") { |f| f.write results.join("\n") }
#
#     results
#   end
#
#   def self.create_province_postalcode
#     results = []
#     china_regions = YAML::load(File.open('lib/data_maker/data/cities.yml'))
#     china_regions.each do |key, value|
#       value.extend Hashie::Extensions::DeepFind
#       postal_code = value.deep_find("zip_code")
#       results << [value["name_en"], postal_code].join(" ")
#     end
#
#     file = "province_postalcode"
#     File.open(file, "w") { |f| f.write results.join("\n") }
#
#     results
#   end
#
#   def self.create_province_cities
#     file_name = nil
#     china_regions = YAML::load(File.open('lib/data_maker/data/cities.yml'))
#     china_regions.extend Hashie::Extensions::DeepFind
#     china_regions.each do |key, value|
#       results = []
#       province = value["name_en"]
#       file_name = "lib/data_maker/data/cn/address/#{province}_cities"
#       value.extend Hashie::Extensions::DeepFind
#       value.deep_find("cities").each do |k, v|
#         results << v["name_en"]
#       end
#       File.open(file_name, "w") { |f| f.write results.join("\n") }
#     end
#   end
#
#   def self.create_city_districts
#     file_name = nil
#     china_regions = YAML::load(File.open('lib/data_maker/data/cities.yml'))
#     china_regions.extend Hashie::Extensions::DeepFind
#     china_cities = china_regions.deep_find_all("cities")
#     china_cities.each do |city|
#       city.each do |key, value|
#         results = []
#         city_name = value["name_en"]
#         file_name = "lib/data_maker/data/cn/address/#{city_name}_districts"
#         value.extend Hashie::Extensions::DeepFind
#         value.deep_find("districts").each do |k, v|
#           results << v["name_en"]
#         end
#         File.open(file_name, "w") { |f| f.write results.join("\n") }
#       end
#     end
#   end
#
#   def self.create_city_province
#     results = []
#     china_regions = YAML::load(File.open('lib/data_maker/data/cities.yml'))
#     china_regions.each do |key, value|
#       value["cities"].each do |k, v|
#         results << [v["name_en"], value["name_en"]].join(", ")
#       end
#     end
#
#     file = "city_province"
#     File.open(file, "w") { |f| f.write results.join("\n") }
#
#     results
#   end
# end
