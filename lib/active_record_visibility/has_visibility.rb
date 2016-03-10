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
      def visible?(attribute=nil)
        hash = generate_hash_for_conditions(attribute)
        visibility = Visibility.where(hash).first
        return true if visibility.nil?
        visibility.is_visible?
      end

      # Checks whether the attribute or object is invisible or not
      def invisible?(attribute=nil)
        !visible?(attribute)
      end

      # Shows the attribute or object from visibility
      def invisible(attribute=nil)
        hash = generate_hash_for_conditions(attribute)
        visibility = Visibility.find_or_create_by(hash)
        visibility.update_attribute(:is_visible, false)
      end

      # Hides the attribute or object from visibility
      def visible(attribute=nil)
        hash = generate_hash_for_conditions(attribute)
        visibility = Visibility.find_or_create_by(hash)
        visibility.update_attribute(:is_visible, true)
      end

      private
      def generate_hash_for_conditions(attribute)
        hash = {visible_id: self.id, visible_type: self.class}
        hash.merge!({visible_attribute: attribute}) if attribute
        hash
      end
    end

  end
end

ActiveRecord::Base.send :include, ActiveRecordVisibility::HasVisibility
