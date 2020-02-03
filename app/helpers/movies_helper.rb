module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  # sort the movies alphabetically
  def sort_movies_alpha
    @movies.sort_by{|movie| movie.title}
  end
  
  # sort the movies by release date
  def sort_movies_release_date
    
  end
end
