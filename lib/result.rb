class Result
  @result = false
  @notice = ''
  @error_string = ''

  def initialize(result)
    @result = result
  end

  def success?
    @result
  end

  def fail?
    !@result
  end

  def error_string
    @error_string
  end

  def error_string=(error_string)
    @error_string = error_string
  end

  def notice
    @notice
  end

  def notice=(notice)
    @notice = notice
  end

  def result=(result)
    @result = result
  end

end
