module Error
  module ErrorHandler

    #클래스에 주입
    def self.included(base)
      base.class_eval do
        rescue_from Exception do |e|
          e.instance_variables.include?(:@isCustom)? respond(e.error, e.status, e.message) : respond(:internal_server_error, 500, '서버 에러!')
        end
      end
    end

    #응답 => 외부 접근 불가능
    private
    def respond(error, status, message)
        json = {
          error: error,
          status: status,
          message: message
      }.as_json
      render json: json, status: status
    end

  end
end