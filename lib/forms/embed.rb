# -*- encoding : utf-8 -*-
class Forms::Embed

  extend ActiveModel::Naming

  attr_accessor :identifier, :settings, :form

  def initialize(identifier, settings = nil)
    @identifier = identifier.to_s
    @settings = {}
    settings ||= Hash.new
    settings.each do |k, v|
      @settings[k.to_sym] = v
    end
  end

  def title
    @settings[:title] || @identifier.gsub('_', ' ').capitalize
  end

  def to_param
    identifier
  end

  def self.name
    "embed"
  end

  def object
    form.object
  end

  def required?
    if settings[:required_if]
      return true if object.send(settings[:required_if])
    end

    if settings[:required_unless]
      return true unless object.send(settings[:required_unless])
    end

    if ["1", "true", 1, true].include?(settings[:required])
      true
    else
      false
    end
  end

  def valid?
    return true unless self.required?
    object.send(self.identifier).count > 0 ? true : false
  end

end
