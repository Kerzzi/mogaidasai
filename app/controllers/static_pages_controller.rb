class StaticPagesController < ApplicationController
  layout 'layouts/about',only: [:about]
  def about
  end

  def help
  end

  def category
  end
end
