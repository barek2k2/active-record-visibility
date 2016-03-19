class Visibility < ActiveRecord::Base
  belongs_to :visible, polymorphic: true
  has_many :visibility_accesses, dependent: :destroy
end
