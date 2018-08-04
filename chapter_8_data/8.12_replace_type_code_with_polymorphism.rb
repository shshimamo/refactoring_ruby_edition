
class MountainBike
  def initialize(params)
    params.each {|key, value| instance_variable_set "@#{key}", value}
  end

  def off_road_ability
    result = @tire_width * TIRE_WIDTH_FACTOR
    if @type_code == :front_suspension || @type_code == :full_suspension
      result += @front_fork_trabel * FRONT_SUSPENSION_FACTOR
    end

    if @type_code == :full_suspension
      result += @rear_fork_travel * REAR_SUSPENSION_FACTOR
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
end

# タイプコードからポリモーフィズムへ
# タイプ毎にクラスを作成する
# これはRubyの長所であり、JavaやC#ではできない
# =>
class RigidMountainBike
  include MountainBike
  def price
      (1 + @commission) * @base_price
  end

  def off_road_ability
    @tire_width * TIRE_WIDTH_FACTOR
  end
end

class FrontSuspensionMountainBike
  include MountainBike
  def price
    (1 + @commission) * @base_price + @front_suspension_price
  end

  def off_road_ability
    result = @tire_width * TIRE_WIDTH_FACTOR
    result += @front_fork_trabel * FRONT_SUSPENSION_FACTOR
    result
  end
end

class FullSuspensionMountainBike
  include MountainBike
  def price
    (1 + @commission) * @base_price + @front_suspension_price + @rear_suspension_price
  end

  def off_road_ability
    result = @tire_width * TIRE_WIDTH_FACTOR
    result += @front_fork_trabel * FRONT_SUSPENSION_FACTOR
    result += @rear_fork_travel * REAR_SUSPENSION_FACTOR
    result
  end
end

module MountainBike
  def initialize(params)
    params.each {|key, value| instance_variable_set "@#{key}", value}
  end

  def wheel_circumference
    Math::PI * (@wheel_diameter + @tire+diameter)
  end
end


