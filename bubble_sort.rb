def bubble_sort(num_arr)
  num_arr.count.times do
    num_arr.each_with_index do |num, idx|
      if idx < num_arr.length - 1
        if num.to_i > num_arr[idx + 1]
          temp_num = num_arr[idx]
          num_arr[idx] = num_arr[idx + 1]
          num_arr[idx + 1] = temp_num
        end
      end
    end
  end
  print num_arr
end

bubble_sort([4,3,78,2,0,2])
