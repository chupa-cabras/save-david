class JunkFood < Food

  def initialize(window, speed = 1)
    super(speed)
    if Random.new.rand(0..1).to_i == 0 then
      @image = Gosu::Image.new(window, "assets/cake.png", true)
    else
      @image = Gosu::Image.new(window, "assets/burger.png", true)
    end
  end

  def injested_by(hero)
    super( hero )
    hero.eat_junk!
  end

  def draw(window)
    @image.draw(self.x, self.y, 5)
  end

end
