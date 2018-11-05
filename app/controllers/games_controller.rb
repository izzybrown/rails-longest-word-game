require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = []
    alphabet_array = ("A" .. "Z").to_a
    counter = 0
    until counter >= 10
      @letters << alphabet_array.sample
      counter += 1
      @letters
    end
  end

  def check_word(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    word = JSON.parse(open(url).read)
    word['found']
  end

  def score
    @word = params[:words]
    @letters = params[:letters].split("")
    if @word.upcase.chars.all? { |letter| @word.upcase.count(letter) > @letters.count(letter) }
      @score = "sorry but #{@word.upcase} cannot be built out of #{@letters}!"
    elsif check_word(@word)
      @score = "Congratulations! #{@word.upcase} is an english word"
    else
      @score = "#{@word.upcase} is not an english word"
    end
  end
end
