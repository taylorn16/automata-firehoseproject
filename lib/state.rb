class Automator
  class State
    attr_reader :transitions
    attr_reader :label

    def initialize(label, success = false)
      @label = label
      @success = success
      @transitions = {}
    end

    def success?
      @success
    end

    def add_transition(input, next_state)
      @transitions[input] = next_state
    end
  end
end
