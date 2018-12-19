Mouse Organ
===========

Ladies and gentlemen, the Marvelous -- Mechanical -- Mouse Organ!

This is a _very_ small mixin that turns a class into a basic state machine.


Installation
------------

Just download lib/mouse_organ.rb into your code.  I mean, it _could_ be a gem.  Sure.  But at less
than 40 lines, that seems more like an abuse of RubyGems than a use.

Or just use it as a pattern of sorts, and roll your own in the same vein.


Example
-------

```{.ruby}
class Foo
  include MouseOrgan

  def initialize
    machine_start(:one)
  end

  def state_one
    transition_to :two
    sleep 1
  end

  def state_two
    transition_to :three
    sleep 1
  end

  def state_three
    throw :machine_stop
  end

  def transition_to(state)
    puts state
    super
  end

end
```


What You Get
------------

Each of your methods that start `state_` define a state of the state machine.  To start the machine,
pass `#machine_start` the initial state name (e.g., `:two` for the state defined by `#state_two`).  

Inside a state method, you can change to a new state using `transition_to(:statename)`. You can
stop the machine using `throw :machine_stop`, or you can override `#machine_stop?` to return true
if the machine should stop.

Passing an invalid state to `#machine_start` or `#transition_to` raises ArgumentError.

The attribute @state holds the current state. 

It might be useful to override `#transition_to` as I have above -- for example, in order to log
every change of state.

