class PositionsMailer < ApplicationMailer
  def new_position_email(email:, creator_profile:, group:, issue:, position:)
    @creator_profile = creator_profile
    @group = group
    @issue = issue
    @position = position

    mail to: email,
      subject: "New Position Created by #{creator_profile.name}"
  end
end
