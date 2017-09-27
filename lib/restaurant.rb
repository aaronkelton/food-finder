class Restaurant

  attr_accessor :name, :cuisine, :price

  @@filepath = nil

  def self.filepath=(path=nil)
    @@filepath = File.join(APP_ROOT, path)
  end

  def self.file_exists?
    # class should know if the restaurant class exists
    if @@filepath && File.exists?(@@filepath)
      true
    else
      false
    end
  end

  def self.file_usable?
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    return true
  end

  def self.create_file
    # create the restaurant file
    File.open(@@filepath, 'w') unless file_exists?
    return file_usable?
  end

  def self.saved_restaurants
    # Should we get a fresh copy from the @@filepath, or store lookup in a variable?
    restaurants = []
    # read the restaurant file
    if file_usable?
      file = File.new(@@filepath, 'r')
      file.each_line do |line|
        restaurants << Restaurant.new.import_line(line.chomp)
      end
      file.close
    end
    return restaurants
    # return instances of restaurant
  end

  def self.build_using_questions
    args = {}
    print "Restaurant name: "
    args[:name] = gets.chomp.strip
    print "Cuisine type: "
    args[:cuisine] = gets.chomp.strip
    print "Average price: "
    args[:price] = gets.chomp.strip
    return self.new(args)
  end

  def initialize(args={})
    @name    = args[:name]    || ""
    @cuisine = args[:cuisine] || ""
    @price   = args[:price]   || ""
  end

  def import_line(line)
    line_array = line.split("\t")
    @name, @cuisine, @price = line_array
    return self
  end

  def save
    return false unless Restaurant.file_usable?
    File.open(@@filepath, 'a') do |file|
      file.puts "#{[@name, @cuisine, @price].join("\t")}\n"
    end
    return true
  end

end
