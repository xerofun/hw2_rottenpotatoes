module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  # Checks if the rating is checked
  def rating_checked?(rating)
    @selected_ratings.has_key?(rating)
  end
  # Generates a sortable column heading
  def sortable_heading(heading, column, id)
    link_to(heading,
        { :controller => :movies,
          :sort_order => column,
          :ratings => @selected_ratings
        },
        :id => id)
  end
end
