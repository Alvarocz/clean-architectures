module CA
  class Either(L, R)
    property left : L?
    property right : R?

    def initialize(@left, @right)
      raise ArgumentError.new "Must provide either left of right" if @left.nil? && @right.nil?
    end

    def self.from_success(value : R)
      instance = Either.allocate
      instance.initialize(nil, value)
      instance
    end

    def self.from_error(value : L)
      instance = Either.allocate
      instance.initialize(value, nil)
      instance
    end

    def left?
      !@left.nil?
    end

    def right?
      !@right.nil?
    end

    def success
      @right
    end

    def error
      @left
    end

    def either(on_left, on_right)
      if left?
        return on_left(@left)
      else
        return on_right(@right)
      end
    end

    def bind(func : _ -> Either(L, R))
      if left?
        return Either.new(@left, nil)
      else
        return func(@right)
      end
    end
  end
end