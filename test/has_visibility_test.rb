require 'test_helper'

class VisibilityTest < ActiveSupport::TestCase
  def test_should_ensure_has_visibility_method_present
    assert Profile.respond_to?(:has_visibility)
  end

  def test_attribute_is_visible_by_default
    profile = Profile.create(:name => 'Ziad Ehsan', :location => "Dhaka, Bangladesh")
    assert profile.visible?(:location)
  end

  def test_attribute_is_invisible
    profile = Profile.create(:name => 'Ziad Ehsan', :location => "Dhaka, Bangladesh")
    profile.invisible(:name)
    assert profile.invisible?(:name)
  end

  def test_hide_an_attribute
    profile = Profile.create(:name => 'Abdul Barek', :location => "Dhaka, Bangladesh")
    assert profile.invisible(:location)
    assert_not profile.visible?(:location)
  end

  def test_visible_and_attribute
    profile = Profile.create(:name => 'Briti', :location => "Pabna, Bangladesh")
    assert profile.visible?(:location)
    profile.visible(:location)
    assert profile.visible?(:location)
  end

  def test_checks_active_record_instance_visibility
    profile = Profile.create(:name => 'Abdul Barek', :location => "Dhaka, Bangladesh")
    assert profile.visible?
    profile.invisible
    assert_not profile.visible?
    assert profile.invisible?
    profile.visible
    assert profile.visible?
  end

  def test_model_has_many_visibilities
    profile = Profile.create(:name => 'Abdul Barek', :location => "Dhaka, Bangladesh")
    profile.visible
    profile.visible(:location)
    profile.invisible(:name)
    assert_equal 3, profile.visibilities.count
  end


end
