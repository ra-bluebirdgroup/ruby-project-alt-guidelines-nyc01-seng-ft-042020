class State < ActiveRecord::Base
  has_many :userstates
  has_many :users, through: :userstates
end
