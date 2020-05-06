require_relative './config/environment'
require 'pry'
require 'rest-client'

def run_app

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
handler.option('By state')  { |selection| selection }
handler.option('All states') { |selection| selection }
handler.option('USA total')  { |selection| selection }
   end
 end


 def sign_in
  exit = nil
  puts "Please enter your user name to sign in:"
  user_name = gets.strip
  user = User.find_by(name: user_name)

 if user
   until exit == true
  puts "Welcome #{user.name}"
  puts "You currently have #{user.states.count} states saved"

  CLI::UI::StdoutRouter.enable
  CLI::UI::Frame.open('Menu') do
  CLI::UI::Prompt.ask('please select a category to view current data:') do |handler|
 handler.option('My states')  { |selection|
      if user.states.empty?
        puts "You have not added any states"
      else
        CLI::UI::Prompt.ask('please select a state:') do |handler|
          user.states.map { |s| handler.option(s.name) { |selection1| display_state_data("#{selection1}")}}
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
                CLI::UI::Prompt.ask('Would to start tracking this state?') do |handler|
                    handler.option("Yes") { |selection6| user.states.push(State.find_by(name: selection3)) }
                    handler.option("No") { |selection7| puts "State is not being tracked." }
                  end
               end
               }
             }
          end
         }

 handler.option('All states') { |selection|
   CLI::UI::Prompt.ask('please select a state:') do |handler|
     State.all.each { |s| handler.option(s.name){ |selection|
          chosen_state = State.find_by(name: "#{selection}")
          puts "State: #{chosen_state.name}"
          puts "dataQualityGrade: #{chosen_state.dataQualityGrade}"
          puts "positive: #{chosen_state.positive}"
          puts "negative: #{chosen_state.negative}"
          puts "recovered: #{chosen_state.recovered}"
          puts "lastUpdateEt: #{chosen_state.lastUpdateEt}"
          puts "death: #{chosen_state.death}"
          puts "totalTestResults: #{chosen_state.totalTestResults}"
       }
     }
    end
  }

 handler.option('USA total')  { |selection| selection }
handler.option('Log out') { |selection| exit = true }
  end
end

end

  else
       puts "User name not found, please sign up."
       run_app
  end

 end


 def sign_up
   puts "Please enter your new user name:"
   user_name = gets.strip
 user = User.create(name: user_name)
 puts "You have created a user #{user_name}."
 sing_in
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
sing_up
     }
#view data
  handler.option('view data')   { |selection|
    view_data_prompt
}
#exit
handler.option('exit')   { |selection|
  puts "Goodbye!"
}

end
end
run_app
