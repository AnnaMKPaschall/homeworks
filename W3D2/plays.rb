require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton #insures we only ever have one instance of database 

  def initialize
    super('plays.db')
    self.type_translation = true #guarantees that anything input as an integer is returned as such 
    self.results_as_hash = true 
  end
end

class Play
  attr_accessor :id, :title, :year, :playwright_id
#allows user to take instance of play, and access these things ^ 
  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
    # we want to return an array of instances 
    # we want one instance bc included singleton module
  end


  def initialize(options)
    #all of the instance variable info is coming from class method 
    @id = options['id'] #will either be defined by class method or unknown (if set by user= nil )
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
    #data could come in from user directly (without ID, that is defined by table) or the self.all method 
    #accessing key in hash with no value will return nil 
  end


  def self.find_by_title(title)
    play = PlayDBConnection.instance.execute(<<-SQL, title)
    SELECT 
      * 
    FROM 
      plays 
    WHERE 
      title = ? 
    SQL
    return nil unless play.length > 0 

    Play.new(play.first)
  end 

  def self.find_by_playwright(name)
    playwright = Playwright.find_by_name(name)
    raise "#{name} not found in DB" unless playwright 

    plays = PlayDBConnection.instance.execute(<<- SQL, playwright.id)
      SELECT 
        * 
      FROM 
        plays 
      WHERE 
       playwright_id = ? 
    SQL 
    plays.map {|play| Play.new(play)}
  end

  # def insert
  #   raise "#{self} is already inserted in database" if self.id 

  #   PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
  #   INSERT INTO 
  #     plays (title, year, playwright_id)
  #   VALUES 
  #     (?, ?, ?)
  #   SQL 

  #   self.id = PlayDBConnection.instance.last_insert_row_id
  # end 

  def create
    raise "#{self} already in database" if self.id --if self(instance) is already in DB it will have a distinct ID. If the id is not nil, it will be in the DB. 
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id) 
     -- Executes SQL query with given information   
      INSERT INTO
        plays (title, year, playwright_id) -- Inserts new row into plays table, specifying all columns 
      VALUES
        (?, ?, ?) -- Values we want to throw in are instance variables. Defined above but need to somehow pass into heredoc. 
        -- Also able to pass in bind elements. Put instance variables at start of SQL and refer to them as ? later in heredoc 
        -- Use ? because we want to prevent against SQL injection attacks 
        -- Only three ?s because ID is automatically set by DB 
        -- Using ?s is way of sanitizing data, ensures they come in safely 
        SQL
    # insert into table of plays a set of values, will run beyond end of character limit. To get around this, use heredoc. 
    #heredoc allows us to embed code that will be read as a string. Denoted by <<-SQL at beginning and SQL at end 
    #will be read as above, but read a string broken up over time. 
    self.id = PlayDBConnection.instance.last_insert_row_id 
    #last_insert_row_id is a SQL method. Gives id of last row inserted into DB 

  end


  def update
    raise "#{self} not in database" unless self.id
    #opposite of what we did in create. Here we only want to update if id already exists 
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
      -- Use heredoc, passing in all of the same things: title, year, playwright_id, AND id
      UPDATE
        plays -- update plays table
      SET
        title = ?, year = ?, playwright_id = ? -- tell it what values to set 
      WHERE 
        id = ? --where ID is equal to last parameter given above. 
    SQL
  end

  # check to make sure instance exists before updating
  # update play table
  # find row by ID 
end


class Playwright
  def self.all 
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    data.map {|datum| Playwright.new(datum)}
  end 

  def self.find_by_name(name)
    person = PlayDBConnection.instance.execute(<<- SQL, name)
    SELECT 
      * 
    FROM 
      playwrights
    WHERE 
      name = ?
    SQL 
    return nil unless person.length > 0 

    Playwright.new(person.first)
  end 

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end 

  def insert 
    raise "#{self} already in database" if self.id #means if self id has truthy val 
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
    INSERT INTO 
      playwrights(name, birth_year)
    VALUES 
      (?, ?)
    SQL 
    self.id = PlayDBConnection.instance.last_insert_row_id
  end 


  def update 
    raise "#{self} not in database" unless self.id 
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year, self.id)
    UPDATE 
      playwrights 
    SET 
      name = ?, birth_year = ? 
    WHERE 
      id = ? 
    SQL 
  end 

  def get_plays 
    raise "#{self} not in database" unless self.id 
    plays = PlayDBConnection.instance.execute(<<- SQL, self.id)
      SELECT 
      * 
      FROM 
      plays 
      WHERE 
      playwright_id = ? 
    SQL 
    plays.map {|play| Play.new(play)}
  end 
end 