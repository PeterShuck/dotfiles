require 'irb/ext/save-history'
require 'irb/completion'

IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

Pry.editor = 'vim -u NONE'
if defined?(PryByebug)
puts 'Setting aliases for pry-byebug'
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'wai', 'whereami'
end

class BigDecimal
  def inspect
    self.to_s
  end
end
