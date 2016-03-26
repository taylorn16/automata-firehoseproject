# A,B
class State
  attr_accessor :transitions

  def initialize(label, success = false)
    @label = label
    @success = success
  end

  def success?
    @success
  end
end

start = State.new('start')
a = State.new('A')
aa = State.new('AA', true)

start.transitions = {'A' => a}
a.transitions     = {'A' => aa}
aa.transitions    = {}

def read_string(chararr, start_state)
  if chararr.size > 0
    head = chararr.shift
    tail = chararr

    unless start_state.transitions.keys.include? head
      puts "No transitions."
      return false
    end

    new_state = start_state.transitions[head]

    return read_string(tail, new_state)
  else
    puts "String consumed."
    return start_state.success?
  end
end

## Execute

p read_string('AA'.chars, start)
p read_string('AB'.chars, start)
