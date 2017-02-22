class GameController < ApplicationController
  def try
    @counter = (cookies[:counter] || 0).to_i
    game = Random.new
    cookies[:random] ||= game.rand(1..100)
    guess = params[:guess].to_i
    random = cookies[:random].to_i
    if guess != 0

      if guess > random
        @result_string = "Guess too high, try again"
      elsif guess < random
        @result_string = "Guess too low, try again"
      else guess == random
        @result_string = "WINNER!!"
      end
      if guess != random
        @counter += 1
      end
    end
    cookies[:counter] = @counter
    render "/game.html.erb"
  end

  def reset
    cookies[:random] = NilClass.new
    cookies[:counter] = 0
    guess = nil
    @result_string = ""
    redirect_to "/try"
  end

end
