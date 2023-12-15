module CA
  struct Left(L)
    property value : L

    def initialize(@value)
    end

    def is_left?
      true
    end

    def is_right?
      false
    end
  end

  struct Right(R)
    property value : R

    def initialize(@value)
    end

    def is_left?
      false
    end

    def is_right?
      true
    end
  end
end
