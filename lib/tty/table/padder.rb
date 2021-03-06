# encoding: utf-8

module TTY
  class Table
    # A class responsible for processing table field padding
    #
    # Used internally by {Table::Renderer}
    #
    # @api private
    class Padder
      include TTY::Equatable

      # Padding for the table cells
      #
      # @return [Array[Integer]]
      attr_reader :padding

      # Initialize a Padder
      #
      # @api public
      def initialize(padding)
        @padding = padding
      end

      # Parse padding options
      #
      # Turn possible values into 4 element array
      #
      # @example
      #   padder = TTY::Table::Padder.parse(5)
      #   padder.padding # => [5, 5, 5, 5]
      #
      # @param [Object] value
      #
      # @return [TTY::Padder]
      #   the new padder with padding values
      #
      # @api public
      def self.parse(value = nil)
        return value if value.is_a?(self)

        new(convert_to_ary(value))
      end

      # Convert value to 4 element array
      #
      # @return [Array[Integer]]
      #   the 4 element padding array
      #
      # @api private
      def self.convert_to_ary(value)
        if value.class <= Numeric
          [value, value, value, value]
        elsif value.nil?
          []
        elsif value.size == 2
          [value[0], value[1], value[0], value[1]]
        elsif value.size == 4
          value
        else
          fail ArgumentError, 'Wrong :padding parameter, must be an array'
        end
      end

      # Top padding
      #
      # @return [Integer]
      #
      # @api public
      def top
        @padding[0].to_i
      end

      # Set top padding
      #
      # @param [Integer] val
      #
      # @return [nil]
      #
      # @api public
      def top=(value)
        @padding[0] = value
      end

      # Right padding
      #
      # @return [Integer]
      #
      # @api public
      def right
        @padding[1].to_i
      end

      # Set right padding
      #
      # @param [Integer] val
      #
      # @api public
      def right=(value)
        @padding[1] = value
      end

      # Bottom padding
      #
      # @return [Integer]
      #
      # @api public
      def bottom
        @padding[2].to_i
      end

      # Set bottom padding
      #
      # @param [Integer] value
      #
      # @return [nil]
      #
      # @api public
      def bottom=(value)
        @padding[2] = value
      end

      # Left padding
      #
      # @return [Integer]
      #
      # @api public
      def left
        @padding[3].to_i
      end

      # Set left padding
      #
      # @param [Integer] value
      #
      # @return [nil]
      #
      # @api public
      def left=(value)
        @padding[3] = value
      end

      # Check if padding is set
      #
      # @return [Boolean]
      #
      # @api public
      def empty?
        padding.empty?
      end

      # Check if vertical padding is applied
      #
      # @return [Boolean]
      #
      # @api public
      def vertical?
        top.nonzero? || bottom.nonzero?
      end

      # Check if horizontal padding is applied
      #
      # @return [Boolean]
      #
      # @api public
      def horizontal?
        left.nonzero? || right.nonzero?
      end

      # String represenation of this padder with padding values
      #
      # @return [String]
      #
      # @api public
      def to_s
        inspect
      end
    end # Padder
  end # Table
end # TTY
