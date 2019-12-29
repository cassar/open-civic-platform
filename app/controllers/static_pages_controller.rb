class StaticPagesController < ApplicationController
  def landing_page
    return unless user_signed_in?

    redirect_to groups_path
  end
end
