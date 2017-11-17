class SimpleDiff
  # Diffing algorithm taken from - https://github.com/paulgb/simplediff
  def self.compare(source, target)
    source ||= []
    target ||= []
    max = si_start = ti_start = 0

    source_matches = Hash.new { |h, k| h[k] = [] }
    source.each_with_index { |el, i| source_matches[el] << i }

    subsequences = Hash.new { |k, v| k[v] = 0 }

    target.each_with_index do |el, ti|
      # Generate a new hash to use for the current iteration
      _subsequences = Hash.new { |k, v| k[v] = 0 }

      # This will return an array of indices that represent the positions
      # of tokens
      # in the source list that match the current token in the target list
      source_matches[el].each do |si|
        # This sets the current subsequence hash to have the length of any
        # subsequence found at a the current source index (si) - 1. This is how
        # subsequence lengths are tracked.
        #
        # If that length is greater than the current max the indexes where the
        # sequence is found are persisted
        if (_subsequences[si] = subsequences[si - 1] + 1) > max
          max = _subsequences[si]
          si_start = si - max + 1
          ti_start = ti - max + 1
        end
      end

      # Assign the current subsequence hash to the previous one so it can be passed
      # into the next iteration.
      subsequences = _subsequences
    end

    if max > 0
      # If the max is greater than 0 a subsequence must have been found. This marks
      # the sequence as being the same in both the source and the target. It then
      # recursively looks at either side of the source and target list to try and
      # find more subsequences.
      start = [source[0...si_start], target[0...ti_start]]
      middle = [
        { change: '=', content: target[ti_start...(ti_start + max)] }
      ]
      finish = [
        source[(si_start + max)..-1],
        target[(ti_start + max)..-1]
      ]

      compare(*start) + middle + compare(*finish)
    else
      # If no subsequence is found then anything in the source list must be a
      # removal and anything in the target must be an addition.
      [].tap do |changes|
        changes << { change: '-', content: source } if !source.empty?
        changes << { change: '+', content: target } if !target.empty?
      end
    end
  end
end