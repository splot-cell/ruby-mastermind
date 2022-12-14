# frozen_string_literal: true

# logic for generating hints from guesses
module EvaluteGuessLogic
  def evaluate_guess(guess, target)
    correct_positions = evaluate_positions(guess, target)

    element_mask = correct_positions.map(&:!)
    correct_values = evaluate_values(apply_code_mask(guess, element_mask),
                                     apply_code_mask(target, element_mask))

    {
      positions: correct_positions.sum { |e| e ? 1 : 0 },
      values: correct_values.sum { |e| e ? 1 : 0 }
    }
  end

  def evaluate_positions(code1, code2)
    code1.map.with_index { |element, i| element == code2[i] }
  end

  def apply_code_mask(code, mask)
    code.map.with_index { |element, i| mask[i] ? element : nil }
  end

  def evaluate_values(query, target)
    values = Array.new(query.length, false)
    element_mask = Array.new(query.length, true)
    query.each_index do |i|
      next unless query[i]

      next unless (found_index = target.index(query[i]))

      element_mask[found_index] = false
      target = apply_code_mask(target, element_mask)
      values[i] = true
    end
    values
  end
end
