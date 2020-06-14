require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.first
    @profile = Profile.first
    @membership = Membership.first
    @group = Group.first
    @confirmed_membership = @membership
    @invitation = Membership.third
    @support = supports(:one)
  end

  test 'user associations' do
    assert @user.profile == @profile
    assert @user.memberships.include? @membership
    assert @user.groups.include? @group
    assert @user.confirmed_memberships.include? @confirmed_membership
    assert @user.invitations.include? @invitation
    assert @user.supports.include? @support
    @user.destroy
    assert_raises(ActiveRecord::RecordNotFound) { @profile.reload }
  end

  test 'after create new profile' do
    User.destroy_all
    assert_difference 'Profile.count' do
      User.create(
        email: 'test@email.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end
  end

  test 'after create replace placeholder' do
    User.destroy_all
    Placeholder.create email: 'test@email.com'
    assert_no_difference 'Profile.count' do

    end
  end
end
