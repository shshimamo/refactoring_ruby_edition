class Post
  states :failure, :error, :success
  attr_accessor :state

  def self.states(*args)
    args.each do |arg|
      define_method arg do
        self.state = arg
      end
    end
  end

  def initialize
    @state = nil
  end
end
