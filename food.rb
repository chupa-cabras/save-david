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

  def x1; @x - SIZE/2; end
  def x2; @x + SIZE/2; end
  def y1; @y - SIZE/2; end
  def y2; @y + SIZE/2; end

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

    hero_x1 = hero.x1 + (hero.size / 2)
    hero_x2 = hero.x2 + (hero.size / 2)
    hero_y1 = hero.y1
    hero_y2 = hero.y2 + (hero.size)




    retorno = x1 < hero_x2 &&
      x2 > hero_x1 &&
      y1 < hero_y2 &&
      y2 > hero_y1


    if retorno then
      puts "x1 #{hero.x1}"
      puts "x2 #{hero.x2}"
      puts "y1 #{hero.y1}"
      puts "y2 #{hero.y2}"

      puts "f x1 #{x1}"
      puts "f x2 #{x2}"
      puts "f y1 #{y1}"
      puts "f y2 #{y2}"
    end
    retorno
  end

  def injested_by(hero)
    
  end

end
