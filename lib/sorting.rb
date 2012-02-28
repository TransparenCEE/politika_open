# -*- encoding : utf-8 -*-
module Sorting
  def self.included(base)
    base.helper_method :sort_by
  end

  def sort_by
    params[:sort] || :basic_information_last_name
  end

  def sort_direction
    params[:dir] || :asc
  end
end
