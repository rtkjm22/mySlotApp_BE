require 'pry'
class ScoresController < ApplicationController
  include Authenticatable
  before_action :authenticate_with_token!, except: %i[new create]

  def new
    @score = Score.new
  end

  def create
    if Score.find_by(unique_id: current_user.unique_id)
      render json: { message: 'ユーザーは既に存在しています。' },
             status: :bad_request
    else
      @score = current_user.scores.create(play_count: 0, last_played: Time.now, win_rate: 0, coin: 100)
      @score.save
    end
  end

  def show
    @score = Score.find_by(unique_id: current_user.unique_id)
    render json: { score: { play_count: @score.play_count, last_played: @score.last_played, win_rateate: @score.win_rate, coin: @score.coin, unique_id: @score.unique_id } },
           status: :ok
  end

  def update
    @score = Score.find_by(unique_id: current_user.unique_id)
    if @score.update(score_params)
      render json: { score: { play_count: @score.play_count, win_rateate: @score.win_rate, coin: @score.coin, unique_id: @score.unique_id } },
             status: :ok
    else
      render json: { message: '不正な値が入力されました。' },
             status: :bad_request
    end
  end

  private

  def score_params
    params.permit(:play_count, :win_rate, :coin, :id)
  end
end
