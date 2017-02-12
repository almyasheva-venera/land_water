class Map

  def initialize(map, x, y)
    @map = map
    @row = x
    @col = y

    @points_wth_ajacent = []
    @row_size = @map.size
    @col_size = @map.first.size
  end

  def show_map
    puts @map
  end

  def already_wth_ajacent_or_nil?(point)
    return true if point.nil?
    @points_wth_ajacent.include?(point)
  end

  def left_water(row, col)
    new_point = [row, col - 1] if col != 0 && @map[row][col - 1] == 'W' 
    return update_point(row, col - 1) unless already_wth_ajacent_or_nil?(new_point)
  end

  def right_water(row, col)
    new_point = [row, col + 1] if col != @col_size - 1 && @map[row][col + 1] == 'W'    
    return update_point(row, col + 1) unless already_wth_ajacent_or_nil?(new_point) 
  end

  def top_water(row, col)
    new_point = [row - 1, col] if row != 0 && @map[row - 1][col] == 'W'
    return update_point(row - 1, col) unless already_wth_ajacent_or_nil?(new_point)
  end

  def bottom_water(row, col)
    new_point = [row + 1, col] if row != @row_size -1 && @map[row + 1][col] == 'W'
    return update_point(row + 1, col) unless already_wth_ajacent_or_nil?(new_point)
  end

  def update_point(row, col)
    @map[row][col] = 'O'
    return [row, col]
  end

  def find_and_mark_adjacent_wpoints(water_points)
    water_points.each do |point|
      row = point.first
      col = point.last
      new_water_points = [left_water(row, col), right_water(row, col), 
                          top_water(row, col), bottom_water(row, col)]
    
      next unless new_water_points.any?
      new_water_points.compact!
      @points_wth_ajacent << point         
      find_and_mark_adjacent_wpoints(new_water_points) 
    end
  end
 
  def find_ocean
    update_point(@row, @col)    
    find_and_mark_adjacent_wpoints([[@row, @col]])
  end 
end

# Example:
map = [ "LWWWWLLLWW",
        "WWLLWLLWWW",
        "WWWWWWWWWW" ]
x = 0
y = 9


map = Map.new(map, x, y)
map.find_ocean
map.show_map
