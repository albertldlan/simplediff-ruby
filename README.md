
SimpleDiff Ruby 1.0
==============

**simplediff-ruby** is a Ruby gem implementation of the [simplediff](https://github.com/paulgb/simplediff) algorithm. It finds the difference between two arrays of strings, numbers, hashes, or arrays.

Use
----

`require` the gem to expose the `SimpleDiff` class.

    require "simplediff-ruby"

Then call `SimpleDiff.compare` to find the diffs.

    source = ['The', 'quick', 'brown', 'fox']
    target = ['The', 'slow', 'green', 'turtle']
    SimpleDiff.compare(source, target)

The output will be an array of hashes representing the differences between the compared arrays.

    [
      { change: '=', content: ['The'] },
      { change: '-', content: ['quick', 'brown', 'fox'] },
      { change: '+', content: ['slow', 'green', 'turtle'] }
    ]

Test
----

Use `ruby test/test.rb` to run the test cases.

    $ ruby test/test.rb

License
-------

SimpleDiff Ruby is available under a zlib/libpng
license. See the provided `LICENSE` file for more details.