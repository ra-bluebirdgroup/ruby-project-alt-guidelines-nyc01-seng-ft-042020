require 'pry'
require 'rest-client'
require 'json'

class User < ActiveRecord::Base
  has_many :user_state_records
  has_many :states, through: :user_state_records

  has_many :user_usa_records
  has_many :usas, through: :user_usa_records

  def view_state(state_name)
   State.find_by(name: state_name)
 end

  def add_state(state_name)

    state = view_state(state_name)
     UserStateRecord.create(user_id: self.id, state_id: state.id)

  end

  def delete_state(state_name)
    state = view_state(state_name)
      state_to_destroy = UserStateRecord.find_by(state_id: state.id)
       state_to_destroy.destroy
  end

  def view_usa_total
    Usa.first
  end

end
