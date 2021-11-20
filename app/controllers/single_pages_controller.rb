# контроллер обрабатывающий единичные страницы
class SinglePagesController < ApplicationController

  def about
  end

  def duplicate
    @duplicates = AstroObject.find_dublicate(:date)
  end

end
