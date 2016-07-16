class MainController < ApplicationController
  def index
    if user_signed_in?
      render template: 'main/logged_in'
    else
      render template: 'main/index'
    end
  end
end
