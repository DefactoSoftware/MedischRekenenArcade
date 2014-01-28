class DifficultyCalculator
  ADDITION_DIFFICULTIES = {
    digit_zero: 0,   # any digit added to zero
    under_ten: 3,   # sum of even digits
    ten: 2,   # sum of odd digits   # sum of even and odd digits
    above_ten: 4    # difficulty of carry (for remembering and then adding)
  }

  SUBTRACTION_DIFFICULTIES = {
    digit_zero: 1,    # difference of zero and any digit
    same_digits: 1,    # difference of same values digits
    even_even: 2,    # difference of even digits
    odd_odd: 2,    # difference of odd digits
    even_odd: 3,    # difference of even and odd digits
    borrow: 2,    # doing a borrow
    twodigit_digit: 4 # difference of two-digit number and digit
  }

  MULTIPLICATION_DIFFICULTIES = {
    digit_zero: 0,
    digit_one: 1,
    digit_two: 2,
    digit_other: 3
  }

  DIVISION_DIFFICULTIES = {
    digit_zero: 0,
    digit_one: 1,
    digit_two: 2,
    digit_other: 3
  }

  def initialize(formula)
    @formula = formula
  end

  def compute_difficulty
    difficulty = 0
    @formula.operations.each do |operation|
      constant1, constant2 = get_constants(operation)
      difficulty = difficulty + compute_step(operation.operator, constant1, constant2)
    end
    difficulty
  end

  def compute_subtraction_difficulty(numbers1, numbers2)
    difficulty = subtraction_compare(numbers1, numbers2)
  end

  def compute_addition_difficulty(numbers1, numbers2)
    if(numbers1.length >= numbers2.length)
      difficulty = addition_compare(numbers1, numbers2)
    else
      difficulty = addition_compare(numbers2, numbers1)
    end
    difficulty
  end

  def compute_division_difficulty(numbers1, numbers2)
    difficulty = division_compare(numbers1, numbers2)
  end

  def compute_multiplication_difficulty(numbers1, numbers2)
    if(numbers1.length >= numbers2.length)
      difficulty = multiplication_compare(numbers1, numbers2)
    else
      difficulty = multiplication_compare(numbers2, numbers1)
    end
    difficulty
  end

  def addition_compare(numbera, numberb)
    difficulty = 0
    numbera.reverse.each_with_index { |a , index|
      b = numberb.reverse[index]
      carry = 0
      case
      when a == nil || b == nil
        difficulty += ADDITION_DIFFICULTIES[:digit_zero]
      when a == 0 || b == 0
        difficulty += ADDITION_DIFFICULTIES[:digit_zero]
      when ( a + b ) == 10
        difficulty += ADDITION_DIFFICULTIES[:ten]
      when ( a + b ) > 10
        difficulty += ADDITION_DIFFICULTIES[:above_ten]
      else
        difficulty += ADDITION_DIFFICULTIES[:under_ten]
      end
    }
    difficulty
  end



  def subtraction_compare(numbera, numberb)
    difficulty = 0
    if numbera.length < numberb.length
      difficulty += SUBTRACTION_DIFFICULTIES[:borrow]
    end
    numbera.reverse.each_with_index { | a , index |
      b = numberb.reverse[index]
      carry = 0
      case
      when a == nil || b == nil
        difficulty += SUBTRACTION_DIFFICULTIES[:digit_zero]
      when a == 0 || b == 0
        if a == 0
          difficulty += SUBTRACTION_DIFFICULTIES[:borrow]
        end
        difficulty += SUBTRACTION_DIFFICULTIES[:digit_zero]
      when a == b
        difficulty += SUBTRACTION_DIFFICULTIES[:same_digits]
      when a < b
        difficulty += SUBTRACTION_DIFFICULTIES[:borrow]
      else
        difficulty += SUBTRACTION_DIFFICULTIES[:even_odd]
      end
    }
    difficulty
  end

  def multiplication_compare(numbera, numberb)
    difficulty = 0
    numbera.reverse.each_with_index { | a , index |
      b = numberb.reverse[index]

      case a
      when 0 || nil
        difficulty += MULTIPLICATION_DIFFICULTIES[:digit_zero]
      when 1
        difficulty += MULTIPLICATION_DIFFICULTIES[:digit_one]
      when 2
        difficulty += MULTIPLICATION_DIFFICULTIES[:digit_two]
      else
        difficulty += MULTIPLICATION_DIFFICULTIES[:digit_other]
      end

      case b
      when 0 || nil
        difficulty += MULTIPLICATION_DIFFICULTIES[:digit_zero]
      when 1
        difficulty += MULTIPLICATION_DIFFICULTIES[:digit_one]
      when 2
        difficulty += MULTIPLICATION_DIFFICULTIES[:digit_two]
      else
        difficulty += MULTIPLICATION_DIFFICULTIES[:digit_other]
      end
      }
    difficulty
  end

  def division_compare(numbera, numberb)
    difficulty = 0
    numbera.reverse.each_with_index { | a , index |
      b = numberb.reverse[index]
      case b
      when 0
        difficulty += DIVISION_DIFFICULTIES[:digit_zero]
      when 1
        difficulty += DIVISION_DIFFICULTIES[:digit_one]
      when 2
        difficulty += DIVISION_DIFFICULTIES[:digit_two]
      else
        difficulty += DIVISION_DIFFICULTIES[:digit_other]
      end
    }
    difficulty = difficulty * numberb.length
  end

  private
  def compute_step(operator, numbers1, numbers2)
    difficulty = 0
    case operator
    when :+
      difficulty = compute_addition_difficulty(numbers1, numbers2)
    when :*
      difficulty = compute_multiplication_difficulty(numbers1, numbers2)
    when :/
      difficulty = compute_division_difficulty(numbers1, numbers2)
    when :-
      difficulty = compute_subtraction_difficulty(numbers1, numbers2)
    end
    difficulty
  end

  def get_constants(operation)
    constants = []
    constants << to_int_array(operation.constant1.value.to_i)
    constants << to_int_array(operation.constant2.value.to_i)
  end

  def to_int_array(integer)
    result_array = []
    while integer > 0
      result_array.unshift integer % 10
      integer /= 10
    end
    result_array
  end
end
