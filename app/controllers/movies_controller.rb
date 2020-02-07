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

    # save the params ratings to session
    if(params[:ratings])
      session[:ratings] = params[:ratings]
    else
      # delete the session variable if the ratings parameter is missing
      session.delete(:ratings)
    end
    
    # save the params sort to session
    if(params[:sort])
      session[:sort] = params[:sort]
    else
      session.delete(:sort)
    end
    
    base = Movie

    # filter movies based off ratings checkboxes
    if(session[:ratings])
      rater = session[:ratings]
      base = base.selected_ratings(rater)
    end
    
    # sort the movies based off of sort parameter
    if(session[:sort])
      sorter = session[:sort]
      base = base.order(sorter)
    end
    
    # highlight selected header
    if(sorter == "title")
      # set the title header class to hilite
      @title_header = 'hilite'
    elsif (sorter == "release_date")
      # set the date header class to hilite
      @date_header = 'hilite'
    end
    
    # set the movies object to be the result of sorting and filtering
    @movies = base.all
    if(session[:ratings].keys.empty? && params[:ratings].keys.empty?)
      @movies = Movie.all
    end
    
    # set the @all_ratings item to the result of all_rating (unique results)
    @all_ratings = Movie.all_ratings
    
    
    if(session[:ratings])
      # keep filters 
      @checked_boxes = session[:ratings]
    else
      # null hash representation if no filters saved in session
      @checked_boxes = {}
    end
    
  end
  
  def new
    # default: render 'new' template
  end

  def creategit
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
