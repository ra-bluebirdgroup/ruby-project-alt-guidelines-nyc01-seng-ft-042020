class UserStateRecord < ActiveRecord::Base
  belongs_to :users
  belongs_to :states
end
