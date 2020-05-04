class User < ActiveRecord::Base
  has_many :user_state_records
  has_many :states, through: :userstates
end
