require_relative './config/environment'
require 'pry'
require 'rest-client'

def run_app
  def view_usa_total
  chosen_state = Usa.all.first
  puts CLI::UI.fmt "Country:".colorize(:blue).on_white + " {{*}} USA"
  puts "Positive: #{chosen_state.positive}"
  puts "Negative: #{chosen_state.negative}"
  puts "Pending: #{chosen_state.pending}"
  puts "Currently hospitalized: #{chosen_state.hospitalizedCurrently}"
  puts "Cumulative hospitalized: #{chosen_state.hospitalizedCumulative}"
  puts "Currently in ICU: #{chosen_state.inIcuCurrently}"
  puts "Cumulative in ICU: #{chosen_state.inIcuCumulative}"
  puts "Currently on ventilator: #{chosen_state.onVentilatorCurrently}"
  puts "Cumulative on ventilator: #{chosen_state.onVentilatorCumulative}"
  puts "Recovered:" + " #{chosen_state.recovered}".colorize(:green)
  puts "Death:" + " #{chosen_state.death}".colorize(:red)
  puts "Hospitalized:" + " #{chosen_state.hospitalized}".colorize(:red)
  puts "Total test results: #{chosen_state.totalTestResults}"
end

  def view_all_states
     State.all.each do |state|
       display_state_data(state.name)
     end
   end

  def display_state_data(state_name)
    chosen_state = State.find_by(name: "#{state_name}")
    puts CLI::UI.fmt "State:".colorize(:blue).on_white + " {{*}} #{chosen_state.name}"
    puts "dataQualityGrade: #{chosen_state.dataQualityGrade}"
    puts "positive: #{chosen_state.positive}"
    puts "negative: #{chosen_state.negative}"
    puts "recovered:" + " #{chosen_state.recovered}".colorize(:green)
    puts "lastUpdateEt: #{chosen_state.lastUpdateEt}"
    puts "death:" + " #{chosen_state.death}".colorize(:red)
    puts "totalTestResults: #{chosen_state.totalTestResults}"
  end

def view_data_prompt

  CLI::UI::Prompt.ask('Which data would you like to view?') do |handler|
  handler.option('By state')  { |selection|

    CLI::UI::Prompt.ask('please select a state:') do |handler|
    State.all.map { |s| handler.option(s.name) { |selection2|
      display_state_data("#{selection2}")
      puts "please sign up to start tracking this state!"
          }
         }
      end
      view_data_prompt
     }

handler.option('All states') { |selection|
  view_all_states
  view_data_prompt
}


handler.option('USA total')  { |selection| selection
  view_usa_total
  view_data_prompt
}

handler.option('back ↩')  { |selection| run_app }

 end
end

#sign in
 def sign_in
  exit = false
  puts "Please enter your user name to sign in:"
  user_name = gets.strip
  user = User.find_by(name: user_name)

 if user
   until exit == true
  puts "Welcome #{user.name},"
  puts "You currently have #{user.states.count} states saved."

  CLI::UI::StdoutRouter.enable
  CLI::UI::Frame.open('Menu') do
  CLI::UI::Prompt.ask('please select a category to view current data:') do |handler|
 handler.option('My states')  { |selection|
      if user.states.empty?
        puts "You have not added any states."
      else
        CLI::UI::Prompt.ask('please select a state:') do |handler|
          user.states.map { |s| handler.option(s.name) { |selection1| display_state_data("#{selection1}")
          if user.states.map { |s| s.name }.include?(selection1)
           CLI::UI::Prompt.ask('Would you like to stop tracking this state?') do |handler|
               handler.option("Yes") { |selection8| user.states.delete(State.find_by(name: selection1)) }
               handler.option("No") { |selection9| puts "This state is being tracked." }
             end
          else
            CLI::UI::Prompt.ask('Would to start tracking this state?') do |handler|
                handler.option("Yes") { |selection10| user.states.push(State.find_by(name: selection1)) }
                handler.option("No") { |selection11| puts "State is not being tracked." }
              end
           end

          }
        }
         end
      end
     }

 handler.option('By state')  { |selection2|
       CLI::UI::Prompt.ask('please select a state:') do |handler|
         State.all.map { |s| handler.option(s.name) { |selection3| display_state_data("#{selection3}")

              if user.states.map { |s| s.name }.include?(selection3)
               CLI::UI::Prompt.ask('Would you like to stop tracking this state?') do |handler|
                   handler.option("Yes") { |selection4| user.states.pop(State.find_by(name: selection3)) }
                   handler.option("No") { |selection5| puts "This state is being tracked." }
                 end

              else
                CLI::UI::Prompt.ask('Would you like to start tracking this state?') do |handler|
                    handler.option("Yes") { |selection6| user.states.push(State.find_by(name: selection3)) }
                    handler.option("No") { |selection7| puts "State is not being tracked." }
                  end
               end
               }
             }
          end
         }

 handler.option('All states') { |selection|
      view_all_states
  }

 handler.option('USA total')  { |selection|
      view_usa_total
  }

 handler.option('Settings') { |selection|
   CLI::UI::Prompt.ask('') do |handler|

     handler.option('change profile name') { |selection|
      puts "Please enter a new profile name:"
      input = gets.strip
      if User.all.map { |u| u.name}.include?(input)
        puts "This username is taken, Please choose a different user name."
      else
      user.update(name: input)
      puts "You name has been changed to #{input}"
     end
      }

     handler.option('delete my account') { |selection|
          user.destroy
          puts "Your account has been deleted"
          exit = true
       }
     handler.option('back ↩') { |selection|  }

   end
  }

handler.option('Log out') { |selection| exit = true }

  end
 end
end

  else
       puts "User name not found, please sign up."

  end

 end

#sign up method
 def sign_up
   puts "Please enter your new user name:"
   user_name = gets.strip
   if User.all.map { |u| u.name }.include?(user_name)
     puts "User name already taken, please choose a different user name."
   else
   User.create(name: user_name)
   puts "You have created a user #{user_name}."
   sign_in
   end
   run_app
 end

#begin
CLI::UI::StdoutRouter.enable
CLI::UI::Frame.open('Covid-19 Tracker v.1.0') do
  # CLI::UI::Frame.open('Frame 2') { puts "inside frame 2" }
  puts "Welcome to Covid-19 Tracker!"
  puts "Please sign up to save most relevant states, and view them later!"
end

CLI::UI::Prompt.ask('Make a selection below to access current US Covid-19 data:') do |handler|
  #sign in option
  handler.option('sign in')  { |selection|
    sign_in
    run_app
    }
#sign up option
  handler.option('sign up')  { |selection|
sign_up
     }
#view data
  handler.option('view data')   { |selection|
    view_data_prompt
}
#exit
handler.option('exit')   { |selection|
  puts "Goodbye!".colorize(:yellow)

}
 end
end
