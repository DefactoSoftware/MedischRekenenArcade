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
      carry: 1,   # carry operation, summation difficulty is seperate
      offset: 1
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

  def do_borrow(num, index)
    if index == num.length-1
      raise 'cannot perform borrow'
    end

    num_borrows = 1
    next_digit = num[index+1].to_i

    if next_digit > 0
      num[index+1] = (next_digit-1).to_s
    else
      num[index+1] = 9.to_s
      num_borrows += do_borrow(num, index+1)
    end
    num_borrows
  end

  def compute_subtraction_difficulty(numbers)
    puts "once"
    if numbers.length == 0
      return 0,0
    elsif numbers.length == 1
      return numbers[0], 0
    end

    num1 = numbers[0]
    num2 = numbers[1]

    num1 = num1.to_s
    num2 = num2.to_s

    puts "Num #{num1} - #{num2}"

    max_length = [num1.length, num2.length].max
    num1 = num1.rjust(max_length, '0')
    num2 = num2.rjust(max_length, '0')

    difficulty = 0
    borrow = 0
    sd = @subtraction_difficulties
    difference = []

    num1 = num1.reverse
    num2 = num2.reverse

    num1.chars.zip(num2.chars).map do |d1, d2|
      d1 = d1.to_i
      d2 = d2.to_i

      d1_is_even = is_even d1
      d2_is_even = is_even d2

      if d1 > d2
        if !d1 or !d2
          difficulty += sd[:digit_zero]
        elsif d1_is_even and d2_is_even
          difficulty += sd[:even_even]
        elsif !d1_is_even and !d2_is_even
          difficulty += sd[:odd_odd]
        elsif d1_is_even and !d2_is_even
          difficulty += sd[:even_odd]
        elsif d2_is_even and !d1_is_even
          difficulty += sd[:even_odd]
        end
        ddiff = d1-d2
      elsif d1 < d2
        num_borrows = do_borrow(num1, index)
        difficulty += sd[:borrow]*num_borrows
        ddiff = 10 + d1 - d2
        difficulty += sd[:twodigit_digit]
      elsif d1 == d2
        difficulty += sd[:same_digits]
        ddiff = 0
      end
      puts "#{ddiff} ddiff"
      difference.push(ddiff.to_s)
    end

    difference.reverse
    difference = difference.join("")
    difference = difference.to_i

    numbers = [difference] + numbers[2...numbers.length]

    difference, sub_difficulty = compute_subtraction_difficulty(numbers)

    difficulty += sub_difficulty

    return difference, difficulty
  end
end
