class User < ActiveRecord::Base
  has_many :user_state_records
  has_many :states, through: :user_state_records
end
