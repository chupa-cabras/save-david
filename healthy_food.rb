class HealthyFood < Food

  def initialize(window, speed = 1)
    super(speed)
     random = Random.new.rand(0..9).to_i
      images =
      *Gosu::Image.load_tiles(window, "assets/greens.png", SIZE, SIZE, false)
      @image = images[random]
  end

  def injested_by(hero)
    super( hero )
    hero.eat_healthy!
  end

  def draw(window)
    @image.draw(self.x, self.y, 6)
  end

end
