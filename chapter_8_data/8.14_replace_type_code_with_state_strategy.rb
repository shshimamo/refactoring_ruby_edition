class MountainBike
  attr_writer :type_code

  def initialize(params)
    set_state_from_hash(params)
  end

  def add_front_suspension(params)
    @type_code == :front_suspension
    set_state_from_hash(params)
  end

  def add_rear_suspension(params)
    unless @type_code == :front_suspension
      raise "you can't add rear suspension unless you have front suspension"
    end
    @type_code == :full_suspension
    set_state_from_hash(params)
  end


  def off_road_ability
    result = @tire_width * TIRE_WIDTH_FACTOR
    if @type_code == :front_suspension || @type_code == :full_suspension
      result += @front_fork_travel * FRONT_SUSPENSION_FACTOR
    end
    if @type_code == :full_suspension
      result += @front_fork_travel * REAR_SUSPENSION_FACTOR
    end
    result
  end

  def price
    case @type_code
    when :rigid
      (1 + @commission) * @base_price
    when :front_suspension
      (1 + @commission) * @base_price + @front_suspension_price
    when :full_suspension
      (1 + @commission) * @base_price + @front_suspension_price + @rear_suspension_price
    end
  end

  private 

  def set_state_from_hash(hash)
    @base_price = hash[:base_price] if hash.has_key?(:base_price)
    if hash.has_key?(:front_suspension_price)
      @front_suspension_price = hash[:front_suspension_price]
    end
    if hash.has_key?(:rear_suspension_price)
      @rear_suspension_price = hash[:rear_suspension_price]
    end
    if hash.has_key?(:comission)
      @rear_suspension_price = hash[:rear_suspension_price]
    end
    if hash.has_key?(:tire_width)
      @tire_width = hash[:tire_width]
    end
    if hash.has_key?(:front_fork_travel)
      @front_fork_travel = hash[:front_fork_travel]
    end
    if hash.has_key?(:rear_fork_travel)
      @rear_fork_travel = hash[:rear_fork_travel]
    end
    @type_code = hash[:type_code] if hash.has_key?(:type_code)
  end
end

# やっとここからリファクタ
# =>

class RigigdMountainBike
  def initialize(params)
    @tire_width = params[:tire_width]
    @base_price = params[:base_price]
    @commission = params[:commission]
  end

  def off_road_ability
    @tire_width * MountainBike::TIRE_WIDTH_FACTOR
  end

  def price
    (1 + @commission) * @base_price
  end
end

class FrontSuspensionMountainBike
  def initialize(params)
    @tire_width = params[:tire_width]
    @base_price = params[:base_price]
    @commission = params[:commission]
    @front_fork_travel = params[:front_fork_travel]
    @front_suspension_price = params[:front_suspension_price]
  end

  def off_road_ability
    @tire_width * MountainBike::TIRE_WIDTH_FACTOR + @front_fork_travel * MountainBike::FRONT_SUSPENSION_FACTOR
  end

  def price
    (1 + @commission) * @base_price + @front_suspension_price
  end
end

class FullSuspensionMountainBike
  def initialize(params)
    @tire_width = params[:tire_width]
    @base_price = params[:base_price]
    @commission = params[:commission]
    @front_fork_travel = params[:front_fork_travel]
    @rear_fork_travel = params[:rear_fork_travel]
    @front_suspension_price = params[:front_suspension_price]
    @rear_suspension_price = params[:rear_suspension_price]
  end

  def off_road_ability
    @tire_width * MountainBike::TIRE_WIDTH_FACTOR +
      @front_fork_travel * MountainBike::FRONT_SUSPENSION_FACTOR +
      @rear_fork_travel * MountainBike::REAR_SUSPENSION_FACTOR
  end

  def price
    (1 + @commission) * @base_price + @front_suspension_price + @rear_suspension_price
  end
end

class MountainBike
  extend Forwardable

  # off_road_ability, priceをStateクラスに移し委譲
  def_delegators :@bike_type, :off_road_ability, :price

  attr_reader :type_code

  def initialize(bike_type)
    @bike_type = bike_type
  end

  def add_front_suspension(params)
    @bike_type = FrontSuspensionMountainBike.new({
      tire_width: @bike_type.tire_width,
      base_price: @bike_type.base_price,
      committion: @bike_type.committion
    }.merge(params))
  end

  def add_rear_suspension(params)
    unless @bike_type.is_a?(FrontSuspensionMountainBike)
      raise "you can't add rear suspension unless you have front suspension"
    end
    @bike_type = FullSuspensionMountainBike.new({
      tire_width: @bike_type.tire_width,
      front_fork_travel: @bike_type.front_fork_travel,
      front_suspension_price: @bike_type.front_suspension_price,
      base_price: @bike_type.base_price,
      committion: @bike_type.committion
    }.merge(params))
  end
end

bike = MountainBike.new(
  FrontSuspensionMountainBike.new(
    tire_width: = @tire_width
    base_price: = @base_price
    commission: = @commission
    front_fork_travel: = @front_fork_travel
    front_suspension_price: = @front_suspension_price
  )
)
