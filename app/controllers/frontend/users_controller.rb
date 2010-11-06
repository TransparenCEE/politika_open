class Frontend::UsersController < Frontend::ApplicationController
  include Sorting
  
  @@extra_chars = {
    'a' => ['á'],
    'c' => ['č'],
    'd' => ['ď'],
    'e' => ['é'],
    'i' => ['í'],
    'l' => ['ĺ'],
    'n' => ['ň'],
    'o' => ['ó'],
    'r' => ['ř', 'ŕ'],
    's' => ['š'],
    't' => ['ť'],
    'u' => ['ú'],
    'y' => ['ý'],
    'z' => ['ž'],
  }
  
  def index
    conditions = conditions_from_params
    @users = User.all(:conditions => conditions, :sort => [[sort_by, sort_direction]])
    criteria = @users
    @per_page = 20
    @pages = (criteria.count.to_f / @per_page.to_f).ceil
    @page = params[:page] ? params[:page].to_i : 1
    criteria.paginate(:page => @page, :per_page => @per_page)
  end
  
  def show
    @user = User.find(params[:id])
    unless @user.is_active
      if current_user && current_user.id == @user.id
        @is_preview = true
      else
        flash[:error] = "Toto konto nie je aktivované."
        redirect_to frontend_users_path
      end
    end
    @forms = @user.visible_forms
    @info = @forms.shift
  end
  
  protected
  
  def conditions_from_params
    # Default
    conditions = {:count_of_invalid_fields => 0, :is_active => true}
    
    # Search
    if params[:search]
      keywords = params[:search].split(' ').collect{|k| /^#{k}/i }
      conditions[:_keywords.in] = keywords
    end
    
    # Filter by letter
    if letter = params[:letter]
      letters = [letter] + (@@extra_chars[letter.downcase]||[])
      letter_regexp = letters.join('|')
      conditions[:basic_information_last_name] = /^(#{letter_regexp})/i
    end
    
    # Sorting
    params[:sort] ||= :updated_at
    params[:dir] ||= :asc
    
    # Special filter
    if params[:election_type] == 'samosprava_obci'
      conditions[:cached_candidature_election] = "voľby do orgánov samosprávy obcí"
    end
    
    conditions
  end
end