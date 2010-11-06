module Sorting
  def self.included(base)
    base.helper_method :sort_by
  end
  
  def sort_by
    params[:sort] || :updated_at
  end
  
  def sort_direction
    params[:dir] || :asc
  end
end