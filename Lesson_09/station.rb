require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Station
  include InstanceCounter
  include Validation
  extend Accessors

  # attr_reader :name, :trains
  attr_accessor_with_history :name, :trains

  validate :name, :presence

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def add_train(train)
    trains << train
  end

  def trains_by_type(type)
    trains.select { |train| train.is_a?(type) }
  end

  def send_train(train)
    trains.delete(train)
  end

  def to_s
    @name
  end

  def each_train
    trains.each.with_index(1) do |item, index|
      yield(item, index)
    end
  end

  protected

  def validate!
    super
    raise 'Длина имени станции должна быть не менее 3 символов' if name.length < 3
  end
end
