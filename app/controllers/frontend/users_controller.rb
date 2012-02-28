# -*- encoding : utf-8 -*-
require 'csv'

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
    respond_to do |format|
      format.html do
        @page = params[:page] ? params[:page].to_i : 1
        @per_page = 20

        if params[:search].present?
          @users = User.search(params[:search], star: true, order: sort_by, sort_mode: sort_direction.to_sym, conditions: conditions, page: @page, per_page: @per_page)
        elsif params[:letter].present?
          @users = User.where(conditions).where("basic_information_last_name LIKE ?", "#{params[:letter]}%").order("#{sort_by} #{sort_direction}").page(@page).per(@per_page)
        else
          @users = User.where(conditions).order("#{sort_by} #{sort_direction}").page(@page).per(@per_page)
        end

        user_count ||= User.count
        @pages = (user_count.to_f / @per_page.to_f).ceil
      end
      format.csv do
        @users = User.where(conditions).order("#{sort_by} #{sort_direction}")
        render :text => collection_as_csv(@users, [:basic_information_first_name,
          :basic_information_last_name,
          :cached_current_party,
          :cached_candidature_party,
          :cached_candidature_election,
          :cached_candidature_function,
          :cached_candidature_town,
          :updated_at])
      end
    end
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

    cookies.permanent[:visit_token] = cookies[:visit_token].present? ? cookies[:visit_token] : SecureRandom.urlsafe_base64
    @user.log_visit(cookies[:visit_token])
  end

  protected

  def conditions_from_params
    # Default
    conditions = {count_of_invalid_fields: 0, is_active: 1}

    # Special filter
    if params[:election_type] == 'samosprava_obci'
      conditions[:cached_candidature_election] = "voľby do orgánov samosprávy obcí"
    end

    conditions
  end

  def collection_as_csv(collection, fields)
    output = ""
    output << CSV.generate_line(fields)
    output << "\n"
    collection.each do |item|
      values = fields.collect do |field|
        item.send(field)
      end
      output << CSV.generate_line(values)
      output << "\n" unless item == collection.last
    end
    output
  end
end
