module Error
  class BadRequest < CustomError
    #초기화
    def initialize
      super(:bad_request, 400, '잘못된 요청입니다.')
    end
  end
end