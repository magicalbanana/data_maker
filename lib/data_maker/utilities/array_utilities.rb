module DataMaker
  module ArrayUtilities
    def self.const_array(argument)
      array = argument.is_a?(Array) ? argument : argument.to_a
      array.extend ArrayUtilities
      freeze_all(array)
    end

    def self.random_pick(array, number)
      indexes = (0...array.length).sort_by{Kernel.rand}[0...number]
      indexes.map { |n| array[n].dup }
    end

    def self.freeze_all(array)
      array.each(&:freeze)
      array.freeze
      array
    end

    def self.shuffle(array)
      array.sort_by{Kernel.rand}
    end

    def random_pick(n)
      ArrayUtilities.random_pick(self, n)
    end

    def freeze_all
      ArrayUtilities.freeze_all(self)
    end

    def shuffle
      ArrayUtilities.shuffle(self)
    end
  end
end
