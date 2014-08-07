#!/usr/bin/env ruby

require 'active_support/inflector'
require 'opencv'
include OpenCV

if ARGV.length < 2
  puts "Without arguments, will process ./David.jpg"
  imageFiles = [ "./David.jpg" ]
else
  imageFiles = ARGV
end

# This is machine learned
data = './haarcascade_frontalface_alt.xml'
detector = CvHaarClassifierCascade::load(data)

# Window to show image
window = GUI::Window.new("Face Detection")

imageFiles.each do |imageFile|
  image = CvMat.load imageFile

  # Look for face in image, draw blue box around it
  numFaces = 0
  detector.detect_objects(image).each do |region|
    numFaces += 1
    color = CvColor::Blue
    image.rectangle! region.top_left, region.bottom_right, :color => color
  end
  puts "Image #{imageFile} has #{numFaces} #{'face'.pluralize(numFaces)}"
  facesExt  = File.extname  imageFile
  facesFile = File.basename imageFile, ".*"
  #image.save("#{facesFile}.faces.#{facesExt}")

  # Show the image with the blue box around the face(s) in a window
  window.show(image)

  GUI::wait_key(10)
  sleep 5
end


