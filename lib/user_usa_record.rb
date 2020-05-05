class UserUsaRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :usa
end
