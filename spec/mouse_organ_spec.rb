require "mouse_organ"


RSpec.describe "MouseOrgan" do

  let(:class_organ1) do
    Class.new do
      include MouseOrgan
    end
  end

  let(:class_organ2) do
    Class.new do
      include MouseOrgan
      attr_reader :state

      def go; machine_start(:one); end

      def state_one; throw :machine_stop; end
    end
  end

  let(:class_organ3) do
    Class.new do
      include MouseOrgan

      def go; machine_start(:one); end

      def state_one;    transition_to :two;    end 
      def state_two;    transition_to :three;  end 
      def state_three;  throw :machine_stop;   end
    end
  end

  let(:class_organ4) do
    Class.new do
      include MouseOrgan

      def go; machine_start(:one); end

      def state_one;    transition_to :two;    end 
      def state_two;    transition_to :three;  end 
      def state_three;  transition_to :one;    end

      def machine_stop?; @state == :three; end
    end
  end

  let(:class_organ5) do
    Class.new do
      include MouseOrgan
      attr_reader :state_history

      def initialize; @state_history = []; end

      def go; machine_start(:one); end

      def state_one;    transition_to :two;    end 
      def state_two;    transition_to :three;  end 
      def state_three;  throw :machine_stop;   end

      def transition_to(state)
        @state_history << state
        super
      end
    end
  end

  let(:organ1) { class_organ1.new }
  let(:organ2) { class_organ2.new }
  let(:organ3) { class_organ3.new }
  let(:organ4) { class_organ4.new }
  let(:organ5) { class_organ5.new }


  describe "#machine_start" do

    it "raises ArgumentError if given an invalid state" do
      expect{ organ1.machine_start(:wrong) }.to raise_error ArgumentError
    end

    it "transitions to the initial state" do
      expect( organ2 ).to receive(:transition_to).with(:one).and_call_original
      organ2.go
    end

    it "transits through the given states and stops when :machine_stop is thrown" do
      expect( organ3 ).to receive(:transition_to).with(:one).and_call_original.ordered
      expect( organ3 ).to receive(:transition_to).with(:two).and_call_original.ordered
      expect( organ3 ).to receive(:transition_to).with(:three).and_call_original.ordered
      organ3.go
    end

    it "transits through the given states and stops when #machine_stop? is true" do
      expect( organ4 ).to receive(:transition_to).with(:one).and_call_original.ordered
      expect( organ4 ).to receive(:transition_to).with(:two).and_call_original.ordered
      expect( organ4 ).to receive(:transition_to).with(:three).and_call_original.ordered
      organ4.go
    end
      
  end # of #machine_start


  describe "#transition_to" do
     
    it "raises ArgumentError if given an invalid state" do
      expect{ organ2.transition_to(:two) }.to raise_error ArgumentError
    end

    it "sets @state to the new state" do
      organ2.transition_to(:one)
      expect( organ2.state ).to eq :one
    end

    it "will allow overriding" do
      organ5.go
      expect( organ5.state_history ).to eq(%i|one two three|)
    end

  end # of #transition_to
  
  
end

