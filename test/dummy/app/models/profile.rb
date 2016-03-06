class Profile < ActiveRecord::Base
  has_visibility :attributes => [:location]
end
