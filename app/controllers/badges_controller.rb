class BadgesController < ApplicationController
  before_action :authenticate_user!
  def index
    @badges = Merit::Badge.all
  end
end
