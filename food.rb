class Food

  SIZE = 32


  attr_reader :x, :y, :angle, :speed
  def initialize(speed = 1)

    random = Random.new.rand(0..1).to_i

    if (random == 0) then
      @x = 40
      @y = Random.new.rand(40..MainGame::HEIGHT).to_i
    else
      @x = MainGame::WIDTH - 40
      @y = Random.new.rand(40..MainGame::HEIGHT).to_i
    end

    @angle = rand(120) + 30
    @angle *= -1  if rand > 0.5
    @speed = speed
  end

  def dx; Gosu.offset_x(angle, speed); end
  def dy; Gosu.offset_y(angle, speed); end

  def move!
    @x += dx
    @y += dy

    if @y < 0
      @y = 0
      bounce_off_edge_y!
    end

    if @y > MainGame::HEIGHT - SIZE
      @y = MainGame::HEIGHT - SIZE
      bounce_off_edge_y!
    end

    if @x < 0
      @x = 0
      bounce_off_edge_x!
    end

    if @x > MainGame::WIDTH - SIZE
      @x = MainGame::WIDTH - SIZE
      bounce_off_edge_x!
    end

  end

  def bounce_off_edge_y!
    @angle = Gosu.angle(0, 0, dx, -dy)
  end

  def bounce_off_edge_x!
    @angle = Gosu.angle(0, 0, -dx, dy)
  end

  def x1; @x ; end
  def x2; @x + SIZE; end
  def y1; @y ; end
  def y2; @y + SIZE; end

  def draw(window)
    color = Gosu::Color::RED

    window.draw_quad(
      x1, y1, color,
      x1, y2, color,
      x2, y2, color,
      x2, y1, color,
    )
  end


  def intersect?(hero)

    point_x = hero.x + (hero.size / 2)
    point_y = hero.y + (hero.size / 2)
    variant = hero.size / 4

    x1 - variant < point_x &&
      x2 + variant > point_x &&
      y1 - variant < point_y &&
      y2 + variant > point_y

  end

  def injested_by(hero)
    
  end

end
