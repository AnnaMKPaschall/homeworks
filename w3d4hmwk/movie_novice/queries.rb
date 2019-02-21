# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#  id          :integer      not null, primary key
#  movie_id    :integer      not null
#  actor_id    :integer      not null
#  ord         :integer


def find_angelina
  #find Angelina Jolie by name in the actors table
  Actor.find_by(name: 'Angelina Jolie') #not plural because actor is returned, not actors table
end

def top_titles
  # get movie titles from movies with scores greater than or equal to 9
  # hint: use 'select' and 'where'
  Movie   
    .select(:title, :id)
    .where('score >= 9') #this can't be symbol because it screws up comparison with integer 
  

end

def star_wars
  #display the id, title and year of each Star Wars movie in movies.
  # hint: use 'select' and 'where'
  Movie
    .select(:id, :title, :yr)
    .where('title LIKE \'%Star Wars%\'') # this looks right but is still breaking my code 
  #   #.where(:title LIKE 'Star Wars%') BAD SYNTAX. NICE TRY. 



end


def below_average_years
  #display each year with movies scoring under 5,
  #with the count of movies scoring under 5 aliased as bad_movies,
  #in descending order
  # hint: use 'select', 'where', 'group', 'order'

  Movie
  .select('yr', 'COUNT(*) AS bad_movies')
  .where('score < 5')
  .group('yr')
  .order('bad_movies DESC')

end

def alphabetized_actors
  # display the first 10 actor names ordered from A-Z
  # hint: use 'order' and 'limit'
  # Note: Ubuntu users may find that special characters
  # are alphabetized differently than the specs.
  # This spec might fail for Ubuntu users. It's ok!
  Actor
  .order('name ASC') #THESE NEED TO GO DIRECTLY BELOW ACTOR OR THEY THROW AN ERROR 
  .limit(10)
  # .select('name', 'COUNT(*)')
  # .where() THESE AREN'T necessary

end

def pulp_fiction_actors
  # practice using joins
  # display the id and name of all actors in the movie Pulp Fiction
  # hint: use 'select', 'joins', 'where'
  Actor
  .select(:name, :id)
  .joins(:movies) #this can't be string because movies is a table. right? 
  .where('title = \'Pulp Fiction\'')

end

def uma_movies
  #practice using joins
  # display the id, title, and year of movies Uma Thurman has acted in
  # order them by ascending year
  # hint: use 'select', 'joins', 'where', and 'order'
  Movie 
  .select(:id, :title, :yr)
  .joins(:castings) #this should be :actor. Why? 
  .where('name = \'Uma Thurman\'')
  .order('yr ASC')
end
