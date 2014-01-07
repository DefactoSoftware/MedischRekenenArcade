module MathDifficultyHelper
  @addition_difficulties = {
    digit_zero: 0,   # any digit added to zero
    under_ten: 3,   # sum of even digits
    ten: 2,   # sum of odd digits   # sum of even and odd digits
    above_ten: 4    # difficulty of carry (for remembering and then adding)
  }

  @subtraction_difficulties = {
      digit_zero: 1,    # difference of zero and any digit
      same_digits: 1,    # difference of same values digits
      even_even: 2,    # difference of even digits
      odd_odd: 2,    # difference of odd digits
      even_odd: 3,    # difference of even and odd digits
      borrow: 2,    # doing a borrow
      twodigit_digit: 4 # difference of two-digit number and digit
  }

  @multiplication_difficulties = {

      digit_zero: 0,
      digit_one: 1,
      digit_two: 2,
      digit_other: 3

  }

  @division_difficulties = {

      digit_zero: 0,
      digit_one: 1,
      digit_two: 2,
      digit_other: 3
  }

  def compute_subtraction_difficulty(numbers1, numbers2)
    difftable = @subtraction_difficulties
    difficulty = 0
    subtraction_compare(numbers1, numbers2)
    return difficulty
  end

  def compute_addition_difficulty(numbers1, numbers2)
    difftable = @addition_difficulties
    difficulty = 0
    if(numbers1.length >= numbers2.length)
      addition_compare(numbers1, numbers2)
    else
      addition_compare(numbers2, numbers1)
    end
    return difficulty
  end

  def compute_division_difficulty(numbers1, numbers2)
    difftable = @division_difficulties
    difficulty = 0
    division_compare(numbers1, numbers2)
    return difficulty
  end

   def compute_multiplication_difficulty(numbers1, numbers2)
    difftable = @multiplication_difficulties
    difficulty = 0
    if(numbers1.length >= numbers2.length)
      multiplication_compare(numbers1, numbers2)
    else
      multiplication_compare(numbers2, numbers1)
    end
  end

  def addition_compare(numbera, numberb)
    numbera.reverse.each_with_index { |a , index|
      @b = numberb.reverse[index]
      @carry = 0
      case
      when a == nil || b == nil
        difficulty += difftable[:digit_zero]
      when a == 0 || b == 0
        difficulty += difftable[:digit_zero]
      when ( a + b ) == 10
        difficulty += difftable[:ten]
      when ( a + b ) > 10
        difficulty += difftable[:above_ten]
      else
        difficulty += difftable[:under_ten]
      end
      }
  end



  def subtraction_compare(numbera, numberb)
    difftable = @subtraction_difficulties
    if numbera.length < numberb.length then difficulty += difftable[:borrow] end
    numbera.reverse.each_with_index { | a , index |
    @b = numberb.reverse[index]
    @carry = 0
    case
    when a == nil || b == nil
      difficulty += difftable[:digit_zero]
    when a == 0 || b == 0
      if a == 0 then difficulty += difftable[:borrow] end
      difficulty += difftable[:digit_zero]
    when a == b
      difficulty += difftable[:same_digits]
    when a < b
      difficulty += difftable[:borrow]
    else
      difficulty += difftable[:even_odd]
    end
    }

  end

def multiplication_compare(numbera, numberb)

    numbera.reverse.each_with_index { | a , index |

    @b = numberb.reverse[index]

    case a
    when 0 || nil
      difficulty += difftable[:digit_zero]
    when 1
      difficulty += difftable[:digit_one]
    when 2
      difficulty += difftable[:digit_two]
    else
      difficulty += difftable[:digit_other]
    end

    case b
    when 0 || nil
      difficulty += difftable[:digit_zero]
    when 1
      difficulty += difftable[:digit_one]
    when 2
      difficulty += difftable[:digit_two]
    else
      difficulty += difftable[:digit_other]
    end

    }
  end

def division_compare(numbera, numberb)
    numbera.reverse.each_with_index { | a , index |
    @b = numberb.reverse[index]
    case b
    when 0
      difficulty += difftable[:digit_zero]
    when 1
      difficulty += difficulty[:digit_one]
    when 2
      difficulty += difficulty[:digit_two]
    else
      difficulty += difficulty[:digit_other]
    end


    }

    difficulty = difficulty * numberb.length
  end

end
