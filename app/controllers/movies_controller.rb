class MoviesController < ApplicationController
  @@necessary_params = [:sort_order, :ratings]

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings.keys

    params_were_missing = false

    if params.has_key?(:sort_order)
      session[:sort_order] = params[:sort_order]
      @sort_order = session[:sort_order]
    else
      params_were_missing = true
    end

    if params.has_key?(:ratings)
      session[:ratings] = params[:ratings]
      @selected_ratings = session[:ratings]
    else
      params_were_missing = true
    end

    if not session.has_key?(:ratings)
      #set default
      session[:ratings] = Movie.all_ratings
    end

    if not session.has_key?(:sort_order)
      session[:sort_order] = :id
    end

    # redirect if parameters were pulled from session
    if params_were_missing
      redirect_to :sort_order => session[:sort_order], :ratings => session[:ratings]
    end

    @movies = Movie.where(:rating => session[:ratings].keys).order(session[:sort_order])
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def sort_order
    @sort_order
  end

  def get_class_for_sort(sort_order)
    if @sort_order == sort_order
      "hilite"
    else
      ""
    end
  end

end
