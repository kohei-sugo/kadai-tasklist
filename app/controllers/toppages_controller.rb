class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
    end
  end
end
