class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = name
    @location = location

    student_hash.each do |key, value|
      if key.to_s.include?("name")
        self.name = value
      else self.location = value
      end
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      Student.new(student)
    end
  end


  def add_student_attributes(attributes_hash)
    attributes_hash.each do |att, value|
      self.send("#{att}=", value)
    end
    self
  end

  def self.all
    @@all
  end
end

