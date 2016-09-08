# контроллер обрабатывающий единичные страницы
class SinglePagesController < ApplicationController
  def about
  end

  def libraries
    @tags=ActsAsTaggableOn::Tag.all
  end

  def addlibraries
    @tag=ActsAsTaggableOn::Tag.new(:name=>params[:addlib])
    @tag.save
    redirect_to '/libraries'
  end
end
