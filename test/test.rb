require_relative "../lib/simplediff-ruby"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use!(Minitest::Reporters::DefaultReporter.new)
class SimpleDiffTest < MiniTest::Test
  test_cases = {
    insertions: [
      {
        source: [1, 3, 4],
        target: [1, 2, 3, 4],
        diff: [
          {change: '=', content: [1]},
          {change: '+', content: [2]},
          {change: '=', content: [3, 4]}
        ]
      },
      {
        source: [1, 2, 3, 8, 9, 12, 13],
        target: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
        diff: [
          {change: '=', content: [1, 2, 3]},
          {change: '+', content: [4, 5, 6, 7]},
          {change: '=', content: [8, 9]},
          {change: '+', content: [10, 11]},
          {change: '=', content: [12, 13]},
          {change: '+', content: [14, 15]}
        ]
      },
      {
        source: [1, 2, 3, 4, 5],
        target: [1, 2, 2, 3, 4, 5],
        diff: [
          {change: '=', content: [1]},
          {change: '+', content: [2]},
          {change: '=', content: [2, 3, 4, 5]}
        ]
      },
      {
        source: [1, 2, 3, 4, 5],
        target: [1, 2, 2, 3, 4, 4, 5],
        diff: [
          {change: '=', content: [1]},
          {change: '+', content: [2]},
          {change: '=', content: [2, 3, 4]},
          {change: '+', content: [4]},
          {change: '=', content: [5]}
        ]
      },
      {
        source: [1, 2, 3, 4, 5],
        target: [1, 2, 1, 2, 3, 3, 2, 1, 4, 5],
        diff: [
          {change: '+', content: [1, 2]},
          {change: '=',content:  [1, 2, 3]},
          {change: '+', content: [3, 2, 1]},
          {change: '=',content:  [4, 5]}
        ]
      }
    ],
    deletions: [
      {
        source: [1, 2, 3, 4, 5],
        target: [1, 2, 5],
        diff: [
          {change: '=', content: [1, 2]},
          {change: '-', content: [3, 4]},
          {change: '=', content: [5]}
        ]
      },
      {
        source: [1, 2, 3, 4, 5, 6, 7, 8],
        target: [3, 6, 7],
        diff: [
          {change: '-', content: [1, 2]},
          {change: '=', content: [3]},
          {change: '-', content: [4, 5]},
          {change: '=', content: [6, 7]},
          {change: '-', content: [8]}
        ]
      },
      {
        source: [1, 2, 3, 4, 5, 1, 2, 3, 4, 5],
        target: [1, 2, 3, 4, 5],
        diff: [
          {change: '=', content: [1, 2, 3, 4, 5]},
          {change: '-', content: [1, 2, 3, 4, 5]}
        ]
      }
    ],
    changes: [
      {
        source: ['The', 'quick', 'brown', 'fox'],
        target: ['The', 'slow', 'green', 'turtle'],
        diff: [
          {change: '=', content: ['The']},
          {change: '-', content: ['quick', 'brown', 'fox']},
          {change: '+', content: ['slow', 'green', 'turtle']}
        ]
      },
      {
        source: ['jumps', 'over', 'the', 'lazy', 'dog'],
        target: ['walks', 'around', 'the', 'orange', 'cat'],
        diff: [
          {change: '-', content: ['jumps', 'over']},
          {change: '+', content: ['walks', 'around']},
          {change: '=', content: ['the']},
          {change: '-', content: ['lazy', 'dog']},
          {change: '+', content: ['orange', 'cat']}
        ]
      }
    ]
  }

  test_cases.each do |key, cases|
    cases.each do |test_case|
      define_method("test_#{key}_#{test_case[:source]}-#{test_case[:target]}".to_sym) do
        assert_equal(
          test_case[:diff],
          SimpleDiff.compare(test_case[:source], test_case[:target])
        )
      end
    end
  end
end
