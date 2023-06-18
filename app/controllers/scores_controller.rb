require 'pry'
class ScoresController < ApplicationController
  include Authenticatable
  before_action :authenticate_with_token!

  def new
    if Score.find_by(unique_id: current_user.unique_id)
      render json: { message: 'ユーザーは既に存在しています。' },
             status: :bad_request
    else
      @score = current_user.score.create(play_count: 0, last_played: Time.now, win_rate: 0, coin: 100)
      
      if @score.save
        render json: {
          message: 'サインアップが完了しました！',
          userInfo: { name: current_user.name, email: current_user.email, unique_id: current_user.unique_id },
          scoreInfo: { play_count: @score.play_count, last_played: @score.last_played, win_rate: @score.win_rate, coin: @score.coin }
        },
        headers: {
          'Access-Control-Allow-Origin': 'http://localhost:3000',
          'Access-Control-Allow-Credentials': 'true'
        },
        status: :ok
      else
        render json: { message: 'ユーザー情報登録が失敗しました。' }, status: :bad_request
      end
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
