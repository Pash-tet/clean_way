class PagesController < ApplicationController
  def home
    @meditation = TodayMeditation.na.find_by!(day: Date.current.day, month: Date.current.month)
  end

  def about
  end
end
