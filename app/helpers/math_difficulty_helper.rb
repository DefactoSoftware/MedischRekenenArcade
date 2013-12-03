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
      num[index+1] = 0.to_s
      num_borrows += do_borrow(num, index+1)
    end
    num_borrows
  end

  def compute_subtraction_difficulty(numbers)
    if numbers.length == 0
      return 0
    elsif numbers.length == 1
      return 0
    end

    num1 = numbers[0]
    num2 = numbers[1]

    if num1 < num2
      num1, num2 = num2, num1
    end

    num1 = num1.to_s
    num2 = num2.to_s

    max_length = [num1.length, num2.length].max

    num1 = num1.rjust(max_length, '0')
    num2 = num2.rjust(max_length, '0')

    difficulty = 0
    borrow = 0
    sd = @subtraction_difficulties
    difference = []

    num1 = num1.reverse
    num2 = num2.reverse

    num1.chars.zip(num2.chars).map.each_with_index do |n,index|
      d1 = n[0].to_i
      d2 = n[1].to_i

      d1_is_even = is_even d1
      d2_is_even = is_even d2

      if d1 > d2
        if d1 == 0 or d2 == 0
          difficulty += sd[:digit_zero]
        elsif d1_is_even and d2_is_even
          difficulty += sd[:even_even]
        elsif !d1_is_even and !d2_is_even
          difficulty += sd[:odd_odd]
        elsif d1_is_even and !d2_is_even
          difficulty += sd[:even_odd]
        end
        ddiff = d1-d2
      elsif d1 < d2
        num_borrows = do_borrow(num1, index)
        difficulty += sd[:borrow]*num_borrows
        ddiff = num_borrows + (d1 - d2)
        difficulty += sd[:twodigit_digit]
      elsif d1 == d2
        difficulty += sd[:same_digits]
        ddiff = 0
      end
      difference.push(ddiff.to_s)
    end
    difference = difference.reverse
    difference = difference.join("")
    difference = difference.to_i

    numbers = [difference] + numbers[2...numbers.length]

    sub_difficulty = compute_subtraction_difficulty(numbers)

    difficulty += sub_difficulty

    return difficulty
  end

  def compute_addition_difficulty(numbers)
    if numbers.length == 0
      return 0, 0
    elsif numbers.length == 1
      return numbers[0], 0
    end

    num1 = numbers[0]
    num2 = numbers[1]

    num1 = num1.to_s
    num2 = num2.to_s

    max_length = [num1.length, num2.length].max

    num1 = num1.rjust(max_length, '0')
    num2 = num2.rjust(max_length, '0')

    difficulty = 0
    carry = 0
    ad = @addition_difficulties
    sum = []

    num1.chars.reverse.zip(num2.chars.reverse).map.each_with_index do |n,index|
      d1 = n[0].to_i
      d2 = n[1].to_i

      d1_is_even = is_even d1
      d2_is_even = is_even d2

      if d1 == 0 or d2 == 0
        difficulty += ad[:digit_zero]
      elsif d1_is_even and d2_is_even
        difficulty += ad[:even_even]
      elsif !d1_is_even and !d2_is_even
        difficulty += ad[:odd_odd]
      elsif d1_is_even and !d2_is_even or !d1_is_even and d2_is_even
        difficulty += ad[:even_odd]
      end

      dsum = d1 + d2 + carry

      if dsum > 9
        carry = 1
        difficulty += ad[:carry]
      else
        carry = 0
      end

      sum.push((dsum % 10).to_s)
    end

    if carry
      sum.push(carry.to_s)
    end

    sum = sum.reverse()
    sum = sum.join("")
    sum = sum.to_i

    numbers = [sum] + numbers[2...numbers.length]

    sum, sub_difficulty = compute_addition_difficulty(numbers)

    difficulty += sub_difficulty

    return sum, difficulty
  end

  def get_single_digit_multiplication_difficulty(d1, d2)
    if d1 == 0 or d2 == 0
      return 0, 1
    end

    res = d1 * d2
    difficulty = ((4/Float(81)) * res).ceil

    # odd numbers are harder to multiply except 1 and 5
    if ![1,5].include? d1 and ![1,5].include? d2 and (is_odd(d1) or is_odd(d2))
      difficulty += 1
    end

    return res, difficulty.to_i
  end

  def compute_simple_multiplication_difficulty(num, digit)
    num = num.to_s

    result = []
    md = @multiplication_difficulties
    carry = 0
    difficulty = 0

    num.chars.reverse.each_with_index do |d, index|
      d = d.to_i
      res, s_diff = get_single_digit_multiplication_difficulty(d, digit)
      difficulty += s_diff

      if carry > 0
        res, carry_sum_difficulty = compute_addition_difficulty([res, carry])
        difficulty += carry_sum_difficulty + md[:carry]
      end

      carry = res/10
      result_digit = (res.to_s[-1...res.to_s.length]).to_i
      result.push(result_digit.to_s)
    end

    if carry > 0
      result.append(carry.to_s)
    end

    result = result.reverse()
    result = result.join("")
    result = result.to_i
    return result, difficulty
  end

  def compute_multiplication_difficulty(numbers)
    if numbers.length == 0
      return 1, 0
    elsif numbers.length == 1
      return numbers[0], 0
    end

    num1 = numbers[0]
    num2 = numbers[1]

    if num1 < num2
      num1, num2 = num2, num1
    end

    num2 = num2.to_s

    difficulty = 0
    borrow = 0
    md = @multiplication_difficulties
    m_numbers = []

    num2.chars.reverse.each_with_index do |d, index|
      d = d.to_i
      m_number, m_diff = compute_simple_multiplication_difficulty(num1, d)
      difficulty += m_diff

      if index > 0
        m_number = (m_number * (10 ** index)).to_i
        difficulty += md[:offset]
      end

      m_numbers.push(m_number)
    end

    m_numbers_sum, m_numbers_diff = compute_addition_difficulty(m_numbers)
    difficulty += m_numbers_diff

    numbers = [m_numbers_sum] + numbers[2...numbers.length]
    product, m_diff = compute_multiplication_difficulty(numbers)

    difficulty += m_diff

    return product, difficulty
  end
end
