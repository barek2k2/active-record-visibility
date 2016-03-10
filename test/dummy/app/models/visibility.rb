class Visibility < ActiveRecord::Base
  belongs_to :visible, polymorphic: true
end
