class PagesController < ApplicationController
  def home
    render Views::Pages::Home.new(
      meditation: TodayMeditation.daily_na.find_by!(day: Date.current.day, month: Date.current.month)
    )
  end

  def about
  end
end
