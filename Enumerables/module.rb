module Enumerable
  def my_each
      result = []
      self.length.times do |index|
          call_result = yield self[index]
          result << call_result
      end
      return result
  end
  
  def my_each_with_index
      result = []
      self.length.times do |index|
          call_result = yield self[index], index
          result << call_result
      end
  end
  
  def my_select
      result = []
      self.my_each do |e|
          if yield e # if block evaluates to true append reuslt
              result << e 
          end
      end
      return result
  end
  
  def my_all?
      number_of_true = 0
      self.my_each do |element|
          if yield element
              number_of_true += 1
          end
      end
      if number_of_true == self.length
          return TRUE
      else
          return FALSE
      end
  end
  
  def my_any?
      self.my_each do |element|
          if yield element
              return TRUE
          end
      end
      return FALSE
  end
  
  def my_none?
    if block_given?
      self.my_each do |e|
        if yield e
          return FALSE
        end
      end
      return TRUE
    else
      self.my_each do |e|
        if e 
          return FALSE
        end
      end
      return TRUE
    end
  end
  
  # def my_count
  #   true_count = 0
  #   if block_given?
  #     self.my_each do |element|
  #       if yield element 
  #         true_count += 1
  #       end
  #     end
  #     return true_count
  #   else 
  #     return self.length
  #   end
  # end
  
  def my_count(optional=nil)
    true_count = 0
    if optional != nil
      self.my_each do |element|
        if optional == element
          true_count += 1
        end
      end
      return true_count
    end
    if block_given?
      self.my_each do |element|
        if yield element
          true_count += 1
        end
      end
      return true_count
    else
      return self.length
    end
  end
  
  def my_map(&block)
    result = []
    if block_given?
      arr = self.to_a
      arr.my_each do |element|
        result << block.call(element)
      end
      return result
    else
      return self.to_a
    end
  end
  
  def my_inject(start=nil)
    arr = self.to_a
    result = 0

    if !start
      result = arr[0]
      arr.my_each_with_index do |element, index|
        if !(index > arr.length - 2)
          call_result = yield result, arr[index]
          call_result = yield result, arr[index + 1]
          result = call_result
        end
      end
      return result
    end
  end
  
  def multiply_els
    result = self.my_inject { |result, element| result * element }
  end
end