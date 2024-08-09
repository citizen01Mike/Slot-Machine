class HomeController < ApplicationController
  def index
    unless session[:money]
      session[:money] = 0
    end
  end
end
