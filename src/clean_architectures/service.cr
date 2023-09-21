require "./either"

module CA
  class Service(I,O)
    def validate(request : I) : Either(String, I)
    end

    def execute(request : I) : Either(String, O)
    end

    def call(request : I) : Either(String, O)
      Either(String, I).new(nil, request)
        .bind(self.validate)
        .bind(self.execute)
    end
  end
end