class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # sort the movies based off of sort parameter
    sorter = params[:sort]
    @movies = Movie.all.order(sorter)
    
    # highlight selected header
    if(sorter == "title")
      # set the title header class to hilite
      @title_header = 'hilite'
    elsif (sorter == "release_date")
      # set the date header class to hilite
      @date_header = 'hilite'
    end
    
    # set the @all_ratings item to the result of all_rating (unique results)
    @all_ratings = Movie.all_ratings
    
    rater = params[:rating]
    if(rater)
      @checked_ratings = rater
      @movies = Movie.selected_ratings
    end
      
  end
  
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
