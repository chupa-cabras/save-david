require "bundler/setup"
require "hasu"

Hasu.load "hero.rb"
Hasu.load "food.rb"
Hasu.load "junk_food.rb"

class MainGame < Hasu::Window

  WIDTH = 640
  HEIGHT = 480

  def initialize
    super(WIDTH, HEIGHT, false)
  end

  def reset
    self.caption = "Save David - The Game"
    @background_image = Gosu::Image.new(self, "assets/ricepaper_V3.png", true)
    @player = Hero.new(self)
    @foods = []
    @font = Gosu::Font.new(self, "Arial", 20)
  end

  def update
    if button_down? Gosu::KbLeft then
      @player.left!
    end
    if button_down? Gosu::KbRight  then
      @player.right!
    end
    if button_down? Gosu::KbUp  then
      @player.up!
    end
    if button_down? Gosu::KbDown  then
      @player.down!
    end
    if button_down? Gosu::KbSpace  then
      puts 'eat'
      @player.eat_junk!
      puts "x1 #{@player.x1}"
      puts "x2 #{@player.x2}"
      puts "y1 #{@player.y1}"
      puts "y2 #{@player.y2}"
    end

    if Gosu.milliseconds / 5000 > @foods.count then
      @foods << JunkFood.new(self, 1 + @foods.count / 10  )
      puts Gosu.milliseconds
    end

    @foods.each do |f|
      if f.intersect?(@player) then
        f.injested_by(@player)
        @foods.delete f
        f = nil
        break
      else
        f.move!
      end 
    end

  end

  def draw
    @player.draw(self)
    @background_image.draw(0, 0, 0);
    @foods.each{ |f| f.draw(self)  }
    
    @font.draw('Tempo: ' + (Gosu.milliseconds / 1000).to_s + ' secs', 15, 15 , 3 , 1, 1, Gosu::Color.argb(70, 0, 0, 0))
    @font.draw('Peso: ' + (@player.weight.to_i).to_s + ' kg', WIDTH - 150, 15 , 3 , 1, 1, Gosu::Color.argb(70, 0, 0, 0))
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

MainGame.run