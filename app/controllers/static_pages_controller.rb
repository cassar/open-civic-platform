class StaticPagesController < ApplicationController
  def coming_soon
    return unless user_signed_in?

    redirect_to groups_path
  end
end
