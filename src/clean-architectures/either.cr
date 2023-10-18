module CA
  struct Either(L, R)
    property left : L?
    property right : R?

    def initialize(@left, @right)
      raise ArgumentError.new "Must provide either left of right" if @left.nil? && @right.nil?
    end

    def self.from_success(value : R)
      instance = Either(L, R).new(nil, value)
      instance
    end

    def self.from_error(value : L)
      instance = Either(L, R).new(value, nil)
      instance
    end

    def left?
      !@left.nil?
    end

    def right?
      !@right.nil?
    end

    def either(on_left, on_right)
      left? ? on_left(@left) : on_right(@right)
    end

    def bind(func)
      left? ? Either(L, R).new(@left, nil) : func(@right)
    end
  end
end
