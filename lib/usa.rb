class Usa < ActiveRecord::Base
  has_many :user_usa_records
  has_many :users, through: :user_usa_records
end
