# -*- encoding : utf-8 -*-
class ItemsController < ApplicationController

  before_filter :login_required
  before_filter :prepare
  before_filter :disable_timestamp_recording, :only => [:create, :update, :destroy]
  after_filter :enable_timestamp_recording, :only => [:create, :update, :destroy]

  def new
    @item = @model_class.new

    @forms = @item.forms
  end

  def create
    collection = current_user.send(@embed.identifier)
    @item = collection.build

    @forms = @item.forms
    valid = true
    @forms.each do |form|
      form.update(params[@embed.settings[:model_name].downcase])
      form.process
      valid = false unless form.valid?
    end

    if valid
      @item.save
      current_user.save(validate: false)
      redirect_to form_path(@embed.settings[:form_identifier])
    else
      flash.now[:error] = "Prosím vyplnte správne všetky povinné položky formulára."
      render :action => "new"
    end
  end

  def edit
    @item = current_user.send(@embed.identifier).find(params[:id])
    @forms = @item.forms
  end

  def update
    @item = current_user.send(@embed.identifier).find(params[:id])
    @forms = @item.forms
    valid = true
    @forms.each do |form|
      form.update(params[@embed.settings[:model_name].downcase])
      form.process
      valid = false unless form.valid?
    end
    if valid
      @item.save(:validate => false)
      current_user.save(validate: false)
      redirect_to form_path(@embed.settings[:form_identifier])
    else
      flash.now[:error] = "Prosím vyplnte správne všetky povinné položky formulára."
      render :action => "edit"
    end
  end

  def destroy
    @item = current_user.send(@embed.identifier).find(params[:id])
    @item.destroy
    current_user.save(validate: false)
    redirect_to form_path(@embed.settings[:form_identifier])
  end

  protected

  def prepare
    @finder = Forms::FormFinder.instance
    @embed = @finder.embed_for_with_identifier(User, params[:embed_id])
    @model_class = @embed.settings[:model_name].constantize
  end

end
