def caesar_cipher(str, shift)
    s_arr = str.chars
    s_arr.collect! do |c|
        ascii = c.ord
        new = c.ord + shift
        if alpha?(ascii)
            if alpha?(new)
                c = new.chr
            elsif uppercase?(ascii)
                c = overflow(new, 65, 90)
            else
                c = overflow(new, 97, 122)
            end
        else
            c
        end
    end
    s_arr.join
end

def alpha?(c)
   c.between?(65, 90) || c.between?(97, 122)
end

def uppercase?(c)
    c.between?(65, 90)
end

def overflow(new, first_char, last_char)
   ((new % (last_char+1)) + first_char).chr
end

caesar_cipher("What a string!", 5)
