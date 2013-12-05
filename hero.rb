class Hero
  

  attr_reader :x, :y, :weight, :frame, :direction, :size, :base_score
  
  def initialize(window)
    @junk = Gosu::Sample.new(window, "assets/bite.wav")
    @powerup = Gosu::Sample.new(window, "assets/powerup.wav")
    @x = MainGame::WIDTH/2
    @y = MainGame::HEIGHT/2
    @weight = 100
    @base_score = 0
    @frame = 0
    @size = 32
    @direction = :left
    @images =
      *Gosu::Image.load_tiles(window, "assets/spritesheet_caveman.png", @size, @size, false)
  end

  def up!
    @y -= (200 / @weight * 2.2 ) 
    @y = 0 if @y < 0
    exercise!
  end

  def down!
    @y += (200 / @weight * 2.2  ) 
    @y = MainGame::HEIGHT - @size if @y > MainGame::HEIGHT - @size 
    exercise!
  end

  def left!
    @x -= (200 / @weight * 2.2 )
    @x = 0 if @x < 0
    @direction = :left
    exercise!
  end

  def right!
    @x += (200 / @weight * 2.2  )
    @x = MainGame::WIDTH - @size if @x > MainGame::WIDTH - @size 
    @direction = :right
    exercise!
  end

  def eat_junk!
    @weight += 3
    @size += 3
    @junk.play
  end

  def eat_healthy!
    @weight -= 2
    @size -= 2 
    @powerup.play
    @base_score += 100
  end

  def exercise!
    @weight -= 0.01 if @weight > 70
    @size -= 0.01 if @size > 32
    @base_score += 0.1
  end

  def draw(window)
    @frame += 0.2
    if @frame > 15 then @frame = 0 end

    variant = @weight - 100
    variant = 200 if variant > 200
    variant = 0 if variant < 0





    c = Gosu::Color.argb(255, 255 , 255 - variant, 255 - variant)

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
