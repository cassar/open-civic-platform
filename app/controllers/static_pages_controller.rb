class StaticPagesController < ApplicationController
  before_action :check_authenticated!

  def landing; end

  private

  def check_authenticated!
    return unless user_signed_in?

    redirect_to home_path
  end
end
