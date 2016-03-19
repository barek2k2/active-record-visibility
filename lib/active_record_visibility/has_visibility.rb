#
# Visibility library
# All attributes and active record objects will be visible by default
#
module ActiveRecordVisibility
  module HasVisibility
    extend ActiveSupport::Concern

    included do
      # Add your included hook here
    end

    module ClassMethods
      def has_visibility(options = {})
        has_many :visibilities, as: :visible,  dependent: :destroy
        include ActiveRecordVisibility::HasVisibility::InstanceMethods
      end
    end

    module InstanceMethods
      # Checks whether the attribute or object is visible or not
      def visible?(attribute=nil, current_user=nil)
        hash = generate_hash_for_conditions(attribute)
        visibility = Visibility.where(hash).first
        if visibility && visibility.visibility_accesses.any?
          return false unless current_user
          return visibility.visibility_accesses.where(:user_id => current_user).any?
        else
          return true if visibility.nil?
          visibility.is_visible?
        end
      end

      # Checks whether the attribute or object is invisible or not
      def invisible?(attribute=nil,current_user=nil)
        !visible?(attribute)
      end

      # Hides the attribute or object from visibility
      def invisible(attribute=nil,users=[])
        hash = generate_hash_for_conditions(attribute)
        visibility = Visibility.find_or_create_by(hash)
        users.each do |user|
          VisibilityAccess.find_by(visibility: visibility, user: user).destroy
        end
        visibility.update_attribute(:is_visible, false) if users.empty?
      end

      # Shows the attribute or object from visibility
      def visible(attribute=nil,users=[])
        hash = generate_hash_for_conditions(attribute)
        visibility = Visibility.find_or_create_by(hash)
        users.each do |user|
          VisibilityAccess.create(visibility: visibility, user: user)
        end
        visibility.update_attribute(:is_visible, true)
      end

      private
      def generate_hash_for_conditions(attribute=nil)
        hash = {visible_id: self.id, visible_type: self.class}
        hash.merge!({visible_attribute: attribute}) if attribute
        hash
      end
    end

  end
end

ActiveRecord::Base.send :include, ActiveRecordVisibility::HasVisibility
