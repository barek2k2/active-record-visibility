class VisibilityAccess < ActiveRecord::Base
  belongs_to :visibility
  belongs_to :user
end
