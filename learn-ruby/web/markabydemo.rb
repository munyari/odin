require 'rubygems'
require 'markaby'

m = Markaby::Builder.new

m.html do
  body do
    div.posts! do
      div.entry do
        p.date Time.now.to_s
        p.content 'Test entry 1'
      end

      div.entry do
        p.date Time.now.to_s
        p.content 'Test entry 2'
      end
    end
  end
end

puts m
