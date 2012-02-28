# -*- encoding : utf-8 -*-
class Forms::Form

  attr_accessor :identifier, :title, :fields, :embeds, :object, :is_being_validated, :order, :multipart, :description

  def initialize(identifier, a_model = nil)
    @identifier = identifier
    @fields = []
    @embeds = []
    @object = a_model
  end

  def attributes_from_hash(hash)
    hash ||= Hash.new
    hash.each do |item, value|
      if item.to_sym == :fields
        value.each do |field|
          field_name, field_settings = *field
          field_type = field_settings["type"] || "text_field"
          new_field = Forms::Field.field_with_identifier_type_settings(field_name, field_type, field_settings)
          new_field.form = self
          new_field.setup
          self.fields << new_field
        end
        next
      end
      if item.to_sym == :embeds
        value.each do |embed_name, embed_settings|
          embed_settings[:form_identifier] = self.identifier
          new_embed = Forms::Embed.new(embed_name, embed_settings)
          new_embed.form = self
          self.embeds << new_embed
        end
        next
      end
      self.instance_variable_set "@#{item}", value
    end
    self.fields = self.fields.sort_by { |field| field.settings[:order] || 999}
  end

  def identifier
    @identifier.to_sym
  end

  def to_param
    identifier.to_s
  end

  def valid?
    self.is_being_validated = true
    valid = true
    fields.each do |field|
      Rails.logger.info "Field #{field.identifier} valid: #{field.valid?}"
      valid = false unless field.valid?
    end
    valid
  end

  def process
    fields.each do |field|
      field.process if field.valid?
    end
  end

  def embeds(what = :all)
    if what == :visible
      @embeds.find_all do |embed|
        if @object.send(embed.identifier).present?
          true
        elsif embed.settings[:show_if]
          show = @object.send(embed.settings[:show_if])
          show ? true : false
        elsif embed.settings[:show_unless]
          show = @object.send(embed.settings[:show_unless])
          show ? false : true
        else
          true
        end
      end.sort_by{|e|e.settings[:order]}
    else
      @embeds
    end
  end

  def order
    @order || 0
  end

  def visible_for?(object)
    if @show_if && !!object.send(@show_if) == false
      false
    else
      true
    end
  end

  def update(data)
    fields.each do |field|
      field.value=(data[field.identifier_with_form.to_s])
    end
  end

  def count_of_fields
    fields.count
  end

  def count_of_required_fields
    count = 0
    fields.each do |field|
      count +=1 if field.required?
    end
    embeds.each do |embed|
      count += 1 if embeds(:visible).include?(embed) || @object.send(embed.identifier).present? || embed.required?
    end
    count
  end

  def count_of_invalid_fields
    count = 0
    fields.each do |field|
      count += 1 if (field.required? && !field.has_value?)
    end
    embeds.each do |embed|
      count += 1 unless embed.valid?
    end
    count
  end

  def count_of_valid_fields
    valid_fields = count_of_required_fields-count_of_invalid_fields
    valid_fields = 0 if valid_fields < 0
    valid_fields
  end

  def has_invalid_fields?
    !(count_of_invalid_fields == 0)
  end

  def filled_fields
    fields.find_all{|field|field.is_filled?}
  end

  def fields(*args)
    options = args.extract_options!
    if options[:except]
      @fields.find_all do |field|
        !options[:except].include?(field.identifier.to_sym)
      end
    else
      @fields
    end
  end

  def visible_fields(no_photo = false)
    @fields.select do |field|
      if no_photo && field.identifier.to_sym == :photo
        false
      elsif field.settings[:show_unless]
        @object.send(field.settings[:show_unless]).blank?
      else
        true
      end
    end
  end

  def sections
    @sections || Hash.new
  end
end
