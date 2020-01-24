class Bird
  # we're not going to use class variables!
  # which is good news...!

  # to create a bird, we will call someting like


  attr_accessor :age, :gender, :species, :id, :name

  def initialize(attr_hash)
    attr_hash.each do |k, v|
      self.send("#{k}=", v) if self.respond_to? k
    end
  end

  def save
    # now we are committing to a db rather than saving to a class variable... what does that look like?
    sql = <<-SQL
      INSERT INTO birds
      (name, gender, species, age)
      VALUES
      (?,?,?,?)
    SQL

    DB[:conn].execute(sql, self.name, self.gender, self.species, self.age)
    # can we query the DB to get back the last bird inserted?
    get_id_sql = <<-SQL
      SELECT MAX(id) FROM birds;
    SQL

    # what about the id coming back from the db???
    max_id_response = DB[:conn].execute(get_id_sql)
    id = max_id_response[0]["MAX(id)"]
    self.id = id
    # what should return?
    self
  end

  def self.all

  end

  def self.create_table
    # Create a database table for birds
     sql = <<-SQL
      CREATE TABLE IF NOT EXISTS birds (
        id INTEGER PRIMARY KEY,
        name TEXT,
        species TEXT,
        gender TEXT,
        age INTEGER
      );
    SQL

    DB[:conn].execute(sql)
  end
end
