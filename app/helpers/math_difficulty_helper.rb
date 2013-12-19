module MathDifficultyHelper
  @addition_difficulties = {
    digit_zero: 1,   # any digit added to zero
    even_even:2,   # sum of even digits
    odd_odd: 2,   # sum of odd digits
    even_odd: 3,   # sum of even and odd digits
    carry: 2    # difficulty of carry (for remembering and then adding)
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
      digit_zero: 0,carry operation, summation difficulty is seperate
      digit_one: 1,
      digit_two: 2.
      digit_large: 3,

  }

  @division_difficulties = {
      # long division
      use_digit: 1,  # brinding down digit from dividend
      multiple_lookup: 1,  # looking up precomputed multiple of divisor
      quotient_update: 1  # updating quotient with digit or period
  }

  def is_even(digit)
    digit % 2 == 0
  end

  def is_odd(digit)
    digit % 2 != 0
  end

def value_for_score(score)
  score > 3 ? 3 : score
end

  def compute_subtraction_difficulty(numbers1, numbers2)


  end
  def compute_addition_difficulty(numbers1, numbers2)
    difftable = @addition_difficulties
    difficulty = 0
    if(numbers1.length >= numbers2.length)
      addition_compare(numbers1, numbers2)
    else
      addition_compare(numbers2, numbers1)
    end


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


  def compute_division_difficulty(numbers1,numbers2)
  end
  def addition_compare (numbera, numberb)
    numbera.reverse.each_with_index { |a , index|

      difftable = @addition_difficulties
      @b = numberb.reverse[index]
      @carry = 0
      case
      when b == nil
        difficulty += difftable[digit_zero:]
      when a == 0 or b == 0
        difficulty += difftable[digit_zero:]
      when is_even(a) == is_even(b)
        difficulty += difftable[even_even:]
        if ( a + b >= 10) {
          difficulty += difftable[carry:]}
      else
        difficulty += difftable[even_odd:]
        if ( a + b >= 10) { difficulty += difftable[carry:]}
      end


    }
  def multiplication_compare (numbera, numberb)
    numbera.reverse.each_with_index { |a , index|
      @b = numberb.reverse[index]

      a >= 3 ? difficulty += difftbable[digit_large:]
      b >= 3 ? difficulty += difftbable[digit_large:]
      a = 2 ? difficulty += difftbable[digit_two:]
      b = 2 ? difficulty += difftbable[digit_two:]
      a = 1 ? difficulty += difftbable[digit_one:]
      b = 1 ? difficulty += difftbable[digit_one:]
      a = 0 ? difficulty += difftbable[digit_zero:]
      b = 0 ? difficulty += difftbable[digit_zero:]
    }
  end

  def subtraction_compare(numbera, numberb)
    numbera.reverse.each_with_index { | a , index|

    difftable = @subtraction_difficulties
    @b = numberb.reverse[index]
    @carry = 0
    case
    when a == b
      difficulty += difftable[same_digits:]
    when a == 0 or b == 0
      difficulty += difftable[digit_zero:]
    when is_even(a) == is_even(b)
      difficulty += difftable[even_even:]
    when a < b
      difficulty +=difftable[:borrow]

    end






    }
  end

  def division_compare (numbera, numberb)
end
