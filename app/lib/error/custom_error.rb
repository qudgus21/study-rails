module Error
  class CustomError < StandardError

    #읽을 수만 있게
    attr_reader :status, :error, :message, :isCustom

    #초기화
    def initialize(error=nil, status=nil, message=nil)
      @error = error || 422
      @status = status || :unprocessable_entity
      @message = message || 'Something went wrong'
      @isCustom = true
    end

  end
end