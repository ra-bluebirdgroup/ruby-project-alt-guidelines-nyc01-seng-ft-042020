class User < ActiveRecord::Base
  has_many :userstates
  has_many :states, through: :userstates
end
