
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
