module CustomFilter
  def indexOf(input, array)
    for i in (0...array.length)
      if input == "#{array[i]}"
        return i
      end
    end
    return -1
  end 
end

Liquid::Template.register_filter(CustomFilter)
