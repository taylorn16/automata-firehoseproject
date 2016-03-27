require_relative 'state'

class Automator
  attr_reader :states

  def initialize(str)
    @states = [Automator::State.new('start')]
    initialize_states_from_labels(get_labels_from_str(str))
    initialize_state_transitions
  end

  def read_string(str)
    current_state = @states.first
    str.upcase.chars.each do |char|
      if current_state.transitions.include? char
        current_state = current_state.transitions[char]
      end
    end

    return current_state.success?
  end

  private

  def get_labels_from_str(str)
    chararr = str.upcase.chars
    labels = []
    chararr.size.times do |n|
      labels << chararr[0, n + 1].join
    end

    labels
  end

  def initialize_states_from_labels(arr)
    arr.each do |label|
      if label == arr.last
        @states << Automator::State.new(label, true)
      else
        @states << Automator::State.new(label)
      end
    end

    return self
  end

  def initialize_state_transitions
    next_state = nil
    @states.each_with_index do |state, i|
      return self if state == @states.last

      next_state = @states[i + 1]
      state.add_transition(next_state.label.chars.last, next_state)
    end
  end
end
