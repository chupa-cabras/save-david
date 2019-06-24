require "bundler/setup"
require "hasu"

Hasu.load "hero.rb"
Hasu.load "food.rb"
Hasu.load "junk_food.rb"
Hasu.load "healthy_food.rb"


class MainGame < Hasu::Window

  WIDTH = 640
  HEIGHT = 480

  def initialize
    super(WIDTH, HEIGHT, false)
  end

  def reset

    self.caption = "Save David - The Game"
    @background_image = Gosu::Image.new(self, "assets/ricepaper_v3.png", true)
    @player = Hero.new(self)
    @foods = []
    @font = Gosu::Font.new(self, "Arial", 20)
    @game_over_font = Gosu::Font.new(self, "Arial", 50)
    @interval = 3000
    @main_song = Gosu::Song.new(self, "assets/main-song.ogg")
    @main_song.play(true)

    @game_over_image = Gosu::Image.new(self, "assets/gameover.jpg", true)
    @game_over_song = Gosu::Song.new(self, "assets/gameover.ogg")
    @final_score = 0

  end

  def update

    if @player.weight > 300 then #game over
      if @final_score == 0 then
        @main_song.stop
        @game_over_song.play false
        @final_score = @player.base_score.to_i + Gosu.milliseconds / 10 
      end
      return
    end

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
      @interval = @interval - 10
    end

    if Gosu.milliseconds > @interval * @foods.count then
      @foods << JunkFood.new(self, 1 + @foods.count / 10  )
      @foods << HealthyFood.new(self,2)  if Random.new.rand(0..2).to_i == 1
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

    if @player.weight > 300 then #game over
      @game_over_image.draw(0, 0, 10);
      @game_over_font.draw("Score Final: #{@final_score}", 210 , HEIGHT / 2 , 11 , 1, 1, Gosu::Color.argb(255, 0, 0, 0))
      return
    end

    @player.draw(self)
    @background_image.draw(0, 0, 0);
    @foods.each{ |f| f.draw(self)  }
    
    @font.draw('Tempo: ' + (Gosu.milliseconds / 1000).to_s + ' secs', 15, 15 , 3 , 1, 1, Gosu::Color.argb(70, 0, 0, 0))
    @font.draw('Peso: ' + (@player.weight.to_i).to_s + ' kg', WIDTH - 150, 15 , 3 , 1, 1, Gosu::Color.argb(70, 0, 0, 0))
    @font.draw('Score: ' + (@player.base_score.to_i).to_s , 15 , HEIGHT - 30 , 3 , 1, 1, Gosu::Color.argb(70, 0, 0, 0))
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

MainGame.run