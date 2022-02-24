module Error
  class NotFound< CustomError
    #초기화
    def initialize
      super(:not_found, 404, '요청한 리소스를 찾을 수 없습니다.')
    end
  end
end