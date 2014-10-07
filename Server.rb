require 'rasem'
require 'sinatra'

a = {}
('A'..'Z').each_with_index do |letter, idx|
  a[letter] = 2*Math::PI/26*idx
end
('a'..'z').each_with_index do |letter, idx|
  a[letter] = 2*Math::PI/26*idx
end

def getPosition rad, deg
  x = Math.sin(deg) * rad
  y = Math.cos(deg) * rad
  return [x,y]
end

get "/:text" do
  @svgs = []
  input = params[:text]
  words = input.split(" ")
  count = 20
  words.each do |text|
    p = [50,50]
    img = Rasem::SVGImage.new(100,100) do
      circle(p[0], p[1], 2)
      chars = text.split("")
      chars.each do |c|
        if a[c] == nil
          a[c] = 0
        end
        p2 = getPosition(count, a[c])
        nextPos = [p[0] + p2[0], p[1] + p2[1]]
        line(p[0], p[1], nextPos[0], nextPos[1])
        #count += 2
        p = nextPos
      end
      text(0,80, text)
    end
    @svgs << img
  end
  erb :index
end