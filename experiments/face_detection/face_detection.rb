#!/usr/bin/env ruby

require 'active_support/inflector'
require 'opencv'
include OpenCV

$verbose = false

def vp(s)
  if $verbose
    puts s
  end
end

no_sleep = false
graphics_file = %w(.jpeg .jpg .gif)
image_files = []

ARGV.each do |arg|
  vp "Argument processing: #{arg}"
  if arg[0] == '-'
    if arg[1] == '-'
      if arg[2] == 'v'
        $verbose = true
        vp "--verbose"
      elsif arg[2] == 'n'
        no_sleep = true
        vp "--no_sleep"
      end
    elsif arg[1] == 'v'
      $verbose = true
      vp "--verbose"
    elsif arg[1] == 'n'
      no_sleep = true
      vp "--no_sleep"
    end
  else
    ext = File.extname arg
    vp "argument file extention is #{ext}"
    if graphics_file.include?(ext)
      image_files << arg
    else
      vp "Unknown file extension: #{ext}"
    end
  end
end
vp "graphics_file is #{graphics_file}"
vp "ARGV is: #{ARGV}"
vp "image_files is #{image_files}"
vp Time.now

if image_files.length == 0
  vp "Without arguments, will process ./David.jpg"
  image_files << "./David.jpg"
end

# This is machine learned
data = './haarcascade_frontalface_alt.xml'
detector = CvHaarClassifierCascade::load(data)

# Window to show image
window = GUI::Window.new("Face Detection")

image_files.each do |image_file|
  image = CvMat.load image_file

  # Look for face in image, draw blue box around it
  num_faces = 0
  detector.detect_objects(image).each do |region|
    num_faces += 1
    color = CvColor::Blue
    image.rectangle! region.top_left, region.bottom_right, :color => color
  end
  puts "Image #{image_file} has #{num_faces} #{'face'.pluralize(num_faces)}"
  faces_ext  = File.extname  image_file
  faces_file = File.basename image_file, ".*"
  #image.save("#{faces_file}.faces#{faces_ext}")

  # Show the image with the blue box around the face(s) in a window
  window.show(image)

  GUI::wait_key(10)
  sleep 5 unless no_sleep
end

vp Time.now

