require 'test_helper'

class HasVisibilityTest < ActiveSupport::TestCase
  def test_should_not_raise_method_missing_error
    Profile.has_visibility
  end

  def test_should_have_visible_instance_method_for_attribute
    profile = Profile.create(:name => 'Ziad Ehsan', :location => "Dhaka, Bangladesh")
    assert_equal true, profile.visible?(:location)
  end

  def test_should_invisible_attribute
    profile = Profile.create(:name => 'Abdul Barek', :location => "Dhaka, Bangladesh")
    assert_equal true, profile.invisible(:location)
    assert_equal false, profile.visible?(:location)
  end

  def test_should_visible_attribute
    profile = Profile.create(:name => 'Briti', :location => "Pabna, Bangladesh")
    assert_equal true, profile.visible?(:location)
    profile.invisible(:location)
    profile.visible(:location)
    assert_equal true, profile.visible?(:location)
  end


end
