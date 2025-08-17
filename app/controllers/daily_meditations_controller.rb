class DailyMeditationsController < ApplicationController
  def index
    @meditation = DailyMeditation.daily_na.find_by!(day: Date.current.day, month: Date.current.month)
  end
end
