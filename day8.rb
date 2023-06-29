require "matrix"

class TreehouseFinder
  def initialize(inputs)
    rows = inputs.map do |line|
      line.chars.map(&:to_i)
    end

    @heights = Matrix.rows(rows) #Creates the matrix by creating rows from each row 
  end

  def visible_trees
    @heights.each_with_index.count do |height, row, col| #iterating through each cell in the matrix 
        #hmm, height row and col 
      visible_left = visible_from_left?(height, row, col)
      puts "row: #{row}, col: #{col}, height: #{height}, visible_left: #{visible_left}"

      visible_from_left?(height, row, col) || #enlisting helper methds to see if the object is visible from a certain direction
        visible_from_right?(height, row, col) ||
        visible_from_top?(height, row, col) ||
        visible_from_bottom?(height, row, col)
    end
  end

  def visible_from_left?(height, row, col)
    if row.zero? 
      true
    else
      (row - 1).downto(0).all? { |row_index|
        @heights[row_index, col] < height
      }
    end
  end

  def visible_from_right?(height, row, col)
    if row == max_row_index
      true
    else
      (row + 1).upto(max_row_index).all? { |row_index|
        @heights[row_index, col] < height
      }
    end
  end

  def visible_from_top?(height, row, col)
    if col.zero?
      true
    else
      (col - 1).downto(0).all? { |col_index|
        @heights[row, col_index] < height
      }
    end
  end

  def visible_from_bottom?(height, row, col)
    if col == max_col_index
      true
    else
      (col + 1).upto(max_col_index).all? { |col_index|
        @heights[row, col_index] < height
      }
    end
  end

  #these two methods define the limits of the matrix, important for determining the right most and bottom most values 
  def max_row_index
    @heights.row_count - 1
  end

  def max_col_index
    @heights.column_count - 1
  end
end


