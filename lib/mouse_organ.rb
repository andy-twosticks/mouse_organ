


##
# A tiny mixin to turn a class into a state machine.
# Example:
#
# class Foo
#   include MouseOrgan
#
#   def initialize
#     machine_start(:one)
#   end
#
#   def state_one
#     transition_to :two
#     sleep 1
#   end
#
#   def state_two
#     transition_to :three
#     sleep 1
#   end
#
#   def state_three
#     throw :machine_stop
#   end
#
#   def transition_to(state)
#     puts state
#     super
#   end
#
# end
#     
module MouseOrgan
  VERSION = "0.1.0"
 
  def machine_start(initial)
    transition_to initial

    catch :machine_stop do
      loop do
        send state_method(state)
        throw :machine_stop if machine_stop?
      end
    end

    self
  end

  def transition_to(state)
    if self.respond_to? state_method(state)
      @state = state
    else
      fail ArgumentError, "Unknown state '#{state}'"
    end

    self
  end

  def machine_stop?
    false
  end

  private

  def state_method(state)
    "state_#@state".to_sym
  end

end # of MouseOrgan

