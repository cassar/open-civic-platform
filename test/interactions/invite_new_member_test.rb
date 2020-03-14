require 'test_helper'

class InviteNewMemberTest < ActiveSupport::TestCase
  setup do
    @group = Group.first
    @invitee_user = User.first
  end

  def interaction
    params = {email: @email, profile_id: @profile_id}
    @interaction ||= InviteNewMember.new params, @group, @invitee_user
  end

  test 'attempt! for non existing user valid email' do
    @email = 'test@example.com'

    assert_difference 'Placeholder.count', 1 do
      interaction.attempt!
    end

    assert_empty interaction.errors
  end

  test 'attempt! for non existing user invalid email' do
    @email = '@example.com'

    assert_no_difference 'Placeholder.count' do
      interaction.attempt!
    end

    assert interaction.errors
  end

  test 'attempt for existing user not already a member email' do
    @email = 'example2@example.com'

    assert_difference 'Membership.count', 1 do
      interaction.attempt!
    end

    assert_empty interaction.errors
  end

  test 'attempt for existing user already a member email' do
    @email = 'example@example.com'

    assert_no_difference 'Membership.count' do
      interaction.attempt!
    end

    assert interaction.errors
  end

  test 'attempt for existing user not already a member profile_id' do
    @profile_id = 3

    assert_difference 'Membership.count', 1 do
      interaction.attempt!
    end

    assert_empty interaction.errors
  end

  test 'attempt for existing user already a member profile_id' do
    @profile_id = 1

    assert_no_difference 'Membership.count' do
      interaction.attempt!
    end

    assert interaction.errors
  end
end
