class Hero
  

  attr_reader :x, :y, :weight, :frame, :direction, :size
  
  def initialize(window)
    @x = MainGame::WIDTH/2
    @y = MainGame::HEIGHT/2
    @weight = 100
    @frame = 0
    @size = 32
    @direction = :left
    @images =
      *Gosu::Image.load_tiles(window, "assets/spritesheet_caveman.png", @size, @size, false)
  end

  def up!
    @y -= (200 / @weight * 2.2 ) 
    exercise!
  end

  def down!
    @y += (200 / @weight * 2.2  ) 
    exercise!
  end

  def left!
    @x -= (200 / @weight * 2.2 )
    @direction = :left
    exercise!
  end

  def right!
    @x += (200 / @weight * 2.2  )
    @direction = :right
    exercise!
  end

  def eat_junk!
    @weight += 1
    @size += 1
  end

  def eat_healthy!
    @weight -= 0.5
    @size -= 0.5 
  end

  def exercise!
    @weight -= 0.01 if @weight > 70
    @size -= 0.01 if @size > 32
  end


  def draw(window)

    @frame += 0.2
    if @frame > 15 then @frame = 0 end



    c = Gosu::Color.argb(255, 255, 255, 255)

    if @direction == :left then
      @images[@frame].draw_as_quad(x1, y1, c, x2, y2, c, x3, y3, c, x4, y4, c, 2.0)
    else
      @images[@frame].draw_as_quad(x2, y2, c, x1, y1, c, x4, y4, c, x3, y3, c, 2.0)
    end


  end

  def x1; @x; end
  def x2; @x + @size; end
  def x3; @x; end
  def x4; @x + @size; end
  
  def y1; @y; end
  def y2; @y; end
  def y3; @y + @size; end
  def y4; @y + @size; end

end
