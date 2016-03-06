module ActiveRecordVisibility
  module HasVisibility
    extend ActiveSupport::Concern

    included do
      # Add your included hook here
    end

    module ClassMethods
      def has_visibility(options = {})
        attributes = options[:attributes]
        if attributes && attributes.any?
          define_method("visible?") do |attribute|
            visibility = Visibility.where(:visible_id => self.id, :visible_type => self.class, :visible_attribute => attribute).first
            return true if visibility.nil?
            return visibility.is_visible?
          end

          define_method("invisible") do |attribute|
            visibility = Visibility.find_or_create_by(:visible_id => self.id, :visible_type => self.class, :visible_attribute => attribute)
            visibility.update_attribute(:is_visible, false)
          end
          define_method("visible") do |attribute|
            visibility = Visibility.find_or_create_by(:visible_id => self.id, :visible_type => self.class, :visible_attribute => attribute)
            visibility.update_attribute(:is_visible, true)
          end
        end
        include ActiveRecordVisibility::HasVisibility::InstanceMethods
      end
    end

    module InstanceMethods
    end

  end
end

ActiveRecord::Base.send :include, ActiveRecordVisibility::HasVisibility
