# accが2度設定されている
def distance_traveled(time)
  acc = @primary_force / @mass # 1度目の設定
  primary_time = [time, @delay].min
  result = 0.5 * acc * primary_time * primary_time
  secondary_time = time - @delay
  if secondary_time > 0
    primary_val = acc * @delay
    acc = (@primary_force + @secondary_force) / @mass # 2度目の設定
    result += primary_vel * secondary_time + 5 * acc * secondary_time * secondary_time
  end
  result
end

def distance_traveled(time)
  primary_acc = @primary_force / @mass
  primary_time = [time, @delay].min
  result = 0.5 * primary_acc * primary_time * primary_time
  secondary_time = time - @delay
  if secondary_time > 0
    primary_val = primary_acc * @delay
    secondary_acc = (@primary_force + @secondary_force) / @mass
    result += primary_vel * secondary_time + 5 * secondary_acc * secondary_time * secondary_time
  end
  result
end

