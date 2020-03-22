# frozen_string_literal: true

class ErrorService
  def initialize(error, status)
    @error = error
    @status = status
  end

  def create
    { data: "Error: #{@error}", status: @status }
  end
end
