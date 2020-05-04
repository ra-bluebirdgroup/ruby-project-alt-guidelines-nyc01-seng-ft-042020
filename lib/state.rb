class State < ActiveRecord::Base
  has_many :user_state_records
  has_many :users, through: :user_state_records
end
