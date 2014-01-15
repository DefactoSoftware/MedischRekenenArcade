class Formula
  attr_reader :result, :operations

  def initialize(operations)
    @operations = operations
  end

  def text
    string = ""
    @operations.each do |operation|
      string = string + "#{operation.text} \n "
    end
    string
  end

  def result
    @operations.last.result
  end
end


class Constant
  def initialize(value)
    @value = value
  end

  def value
    if @value.is_a?(Operation)
      @value.result
    else
      @value
    end
  end
end

class Operation
  def initialize(operator, constant1, constant2)
    @operator = operator
    @constant1 = constant1
    @constant2 = constant2
  end

  def text
    "#{@constant1.value} #{@operator} #{@constant2.value}"
  end

  def result
    result = @constant1.value.send(@operator, @constant2.value)
    result.is_a?(Float) ? result.round(2) : result
  end
end
