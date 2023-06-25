grid = []

visibleTrees = []

visible = 0
isVisible = false 

File.readlines('data.txt', chomp: true).each do |line|
  grid.push(line.split('').map(&:to_i))
end

row = 0
perimeter = (grid.count + grid[0].count)*2

def getDirections(grid, row, col)
    right = grid[row][col+1]
    left = grid[row][col-1]
    above = grid[row-1][col]
    below = grid[row+1][col]
    [right, left, above, below]
end 

def dig(grid, row, col, item)
    dir = grid[row][col]
    puts("*", item, ">", dir, "*")
    if item > dir 
        isVisible = true 
    else
        puts "not visible"
        isVisible = false 
    end 
    puts isVisible
    isVisible
end 

grid.each do |line|
    col = 0
    line.each do |item|
        itemCoord = [row, col]
        #Avoiding the perimeter 
        if row == 0 || row == grid.count-1
            col+=1 
            next
        end 
        if col == 0 || col == line.count-1 
            col+=1
            next
        end
        
        right, left, above, below = getDirections(grid, row, col)
        directions = [right, left, above, below] 
        dirHash = Hash["right", right, "left", left, "above", above, "below", below]
        dirHash.each do |key, value|
            if value < item #if the adj tree is smaller 
                isVisible = true 
                puts(item, key, value)
                if key == "above"
                    limit = row 
                    until limit < 0 || isVisible == false
                        isVisible = dig(grid, limit, col, item)
                        limit-=1
                    end 
                elsif key == "below"
                    limit = row 
                    until limit > grid.count-1 || isVisible == false
                        isVisible = dig(grid, limit, col, item)
                        limit+=1
                    end 
                elsif key == "right"
                    limit = col
                    until limit >  grid[0].count-1 || isVisible == false
                        isVisible = dig(grid, row, limit, item)
                        limit+=1
                    end 
                elsif key == "left" 
                    limit = col 
                    until limit < 0 || isVisible == false
                        isVisible = dig(grid, row, limit, item)
                        limit-=1
                    end 
                end 
                #Disconnect here 
                if isVisible == true 
                    puts(" Item: ",grid[row][col]," at ",itemCoord)
                    visibleTrees << [item, "at: #{itemCoord}"]
                    visible+=1
                    isVisible = false
                end  
            end  
        end 
         col+=1
    end 
    row+=1
end 



#currently, this only take into account immediate surroundings
#what I could do is create a helper function that digs through until it finds something 

puts(visible, "+", perimeter-4, "=", (visible+perimeter-4))


#30373
#25512
#65332
#33549
#35390

#ok so Whats going on here????

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





#3037325512653323354935390
#3037325512653323354935390