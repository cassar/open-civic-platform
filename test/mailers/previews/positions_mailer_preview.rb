# Preview all emails at http://localhost:3000/rails/mailers/positions_mailer
class PositionsMailerPreview < ActionMailer::Preview
  def new_position_email
    PositionsMailer.new_position_email(
      email: 'a@b.com',
      creator_profile: Profile.first,
      group: Group.first,
      issue: Issue.second,
      position: Position.first
    )
  end
end
