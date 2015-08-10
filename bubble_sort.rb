def bubble_sort(arr)
  n = arr.length
  loop do
      swapped = false
      for i in 1..(n-1)
          if arr[i - 1] > arr[i]
            # swap arr[i-1] and arr[i]
            arr[i-1] ^= arr[i]
            arr[i] ^= arr[i-1]
            arr[i-1] ^= arr[i]
            swapped = true
          end
      end
      n -= 1
    break if !swapped
  end
  arr
end


p bubble_sort([4,3,78,2,0,2])


def bubble_sort_by(arr)
  n = arr.length
  loop do
    swapped = false
    for i in 1..(n-1)
      if (yield(arr[i - 1], arr[i])) > 0
        # swap arr[i-1] and arr[i]
        temp = arr[i-1]
        arr[i-1] = arr[i]
        arr[i] = temp
        swapped = true
      end
    end
    n -= 1
    break if !swapped
  end
  arr
end

p bubble_sort_by(["hi","hello","hey"]) { |left,right| left.length - right.length }
