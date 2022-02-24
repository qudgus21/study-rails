class ApplicationController < ActionController::Base

  #custrom error
  include Error::ErrorHandler

  # 숫자인지
  def self.is_number(object)
    true if Float(object) rescue false
  end

  # 배열 요소가 모두 not nil인지
  def self.check_not_nil_all(*arg)
    arg.each {|p|
      !p && (return false)
    }
    return true
  end

end
