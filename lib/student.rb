class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL    

    CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL

    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?);
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students;").flatten[0] #<---*[0][0]
    #?########################################
    #?WHY DOES @ID WORK BUT NOT SELF.ID!?!??!
    #?########################################
  end

  def self.create(name:, grade:)
    student_object = Student.new(name, grade)
    student_object.save
    return student_object
  #There is a better way to write this
  # But I cannot remember how.. or where to locate it..
  #A better way to return the object without repetitive lines
  end











  
end

#write the CLASS METHOD that creates the table
 # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
