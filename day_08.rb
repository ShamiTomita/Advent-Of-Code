require 'matrix'
require 'byebug'


rows = File.readlines('data.txt', chomp: true).map do |line|
  line.chars.map(&:to_i)
end

@heights = Matrix.rows(rows)


def visible_trees 
  @heights.each_with_index.count do |height, row, col|
    visible_from_left?(height, row, col) || 
    visible_from_right?(height, row, col) ||
    visible_from_top?(height, row, col) || 
    visible_from_bottom?(height, row, col)
  end 
end 

def scenic_score 
  max = 0
  @heights.each_with_index.count do |height, row, col|
    look_left = look_left(height, row, col)
    look_right = look_right(height, row, col)
    look_up = look_up(height, row, col)
    look_down = look_down(height, row, col) 
    #puts ("For #{height} at #{row} #{col} => left: #{look_left} * right: #{look_right} * down: #{look_down} * up: #{look_up}")
    score = (look_left * look_right * look_down * look_up)
    if max < score
       max = score
    end 
  end 
  max
end 


def look_left(height, row, col)
  score = 0
  if col.zero? 
    return score 
  else 
    (col - 1).downto(0).each do |col_index|
      #puts("LOOKING left #{height} at #{row}, #{col_index} > #{@heights[row, col_index]} at #{row}, #{col_index}")
      if height > @heights[row, col_index] 
        #puts("Score left")
         score += 1
      else 
        score += 1 
        #print(row, row_index, "BREAK ON Left") 
        break
      end 
    end 
  end 
  score
end

def look_right(height, row, col)
  score = 0
  if col == max_col_index
    return score 
  else 
    (col + 1).upto(max_col_index).each do |col_index|
      #puts("LOOKING right #{height} at #{row}, #{col_index} > #{@heights[row, col_index]} at #{row}, #{col_index}")
      if height > @heights[row, col_index] 
        #puts("Score right")
         score += 1
      else
        score += 1 
        #print(row, row_index, "BREAK ON RIGHT") 
        break 
      end 
    end 
    score
  end
end
def look_up(height, row, col)
  score = 0
  if row.zero? 
    return score 
  else 
    (row-1).downto(0).each do |row_index|
      #puts("LOOKING UP #{height} at #{row}, #{col} > #{@heights[row_index, col]} at #{row_index}, #{col}")
      if height > @heights[row_index, col] 
        #puts("Score up")
         score += 1   
      else 
        score += 1 
        break
      end 
    end 
    score
  end 
end

def look_down(height, row, col)
  score = 0
  if row ==  max_row_index
    return score 
  else 
    (row+1).upto(max_row_index).each do |row_index|
     # puts("Looking down #{height} at #{row}, #{col} > #{@heights[row_index, col]} at #{row_index}, #{col}")
      if height > @heights[row_index, col] 
        #puts("SCORE Down")
         score += 1  
      else 
        score += 1 
        break
      end 
    end 
    score
  end 
end
########################################
def visible_from_left?(height, row, col)
  if row.zero? 
      true 
  else 
    (row - 1).downto(0).all? {|row_index|
    @heights[row_index, col] < height
    }
  end 
end 

def visible_from_right?(height, row, col)
  if row == max_row_index
    true 
  else 
    (row + 1).upto(max_row_index).all? {|row_index|
    @heights[row_index, col] < height
    }
  end 
end 

def visible_from_top?(height, row, col)
  if col.zero? 
    true 
  else 
    (col -1 ).downto(0).all? {|col_index|
    @heights[row, col_index] < height
    }
  end 
end 

def visible_from_bottom?(height, row, col)
  if col == max_col_index
    true 
  else 
    (col + 1).upto(max_col_index).all? {|col_index|
    @heights[row, col_index] < height
    }
  end 
end 

def max_row_index 
  @heights.row_count-1
end 

def max_col_index 
  @heights.column_count-1
end 



puts(scenic_score)