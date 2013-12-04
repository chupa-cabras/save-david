class JunkFood < Food

  def initialize(window, speed = 1)
    super(speed)
    @image = Gosu::Image.new(window, "assets/cake.png", true)
  end

  def injested_by(hero)
    super( hero )
    hero.eat_junk!
  end

  def draw(window)
    @image.draw(self.x, self.y, 5)
  end

end
