
--* This example performs a search on Instagram and displays the locations of the phtos on a map. Tap on a pin to display the associated photo.

-- This is the search term. Feel free to change it!
searchTerm = "snow"

-- Add a nice wood background. (Double tap the url to preview)
woodURL = "http://skpt.it/n3"
screen.background(woodURL)

-- Add a shadow underneath the map.
iurl = "http://skpt.it/h6"
img = image.new(iurl, {x=63, y=40})
screen.add(img)

map = map.new(71, 46, 882, 650)
screen.add(map)

-- Add some map-like folds to give the map some style.
foldURL = "http://skpt.it/a2"
folds = image.new(foldURL, {x=52, y=46})
screen.add(folds)

--This is a custom function that gives an image a border and dropshadow.
function makeBorderedImage(img, w, h)
  local bS = 20
  local aS = 20
  drawing.begin(w + aS+bS, h + aS+bS)
  drawing.fillcolor(0,0,0,0)
  drawing.shadow(0, 0, 4, 0, 0, 0, 128)
  drawing.fillrect(0,0,w+aS+bS,h+aS+bS)
  drawing.fillcolor(255,255,255,255)
  drawing.fillrect(aS/2,aS/2, w+aS/2,h+aS/2)
  drawing.shadow(0,0,0, 255, 255, 255 ,0)
  drawing.drawimage(img, aS/2+bS/2, aS/2+bS/2, w-bS/2, h-bS/2)
  img = drawing.finish()
  return img
end

-- When an image loads, this gets called. 
-- Here, we animate it in, and give it a nice bordered background.
function thumbload(img)
  x, y, w, h = object.getframe(img)
  
  borderedImage = makeBorderedImage(img, w, h)
  x, y, w, h = object.getframe(borderedImage)
  
  screen.add(borderedImage)
  object.alpha(borderedImage, 0, 0)
  object.alpha(borderedImage, 1, 0.5)
  object.moveto(borderedImage, 340, -200, w/2, h/2, 0)
  object.moveto(borderedImage, 340, 150, w/2, h/2, 0.36)
  object.makeinteractive(borderedImage)
end

-- When we tap on a pin, load the associated photo.
function pinSelect(pin)
  theurl = object.getmetadata(pin, "url")
  thumb = image.new(theurl, nil, thumbload)
end

--When the Instagram search request finishes, this function gets called.
function gotInstagram(data)
  for k,v in pairs(data) do
    local key = k
    local url = v["data.images.standard_resolution.url"]
    local lat = v["data.location.latitude"]
    local lon = v["data.location.longitude"]
    local caption = v["data.caption.text"]
    if lat and lon then
      anno = annotation.new(lat, lon)
      annotation.title(anno, caption)
      map.addannotation(map, anno, pinSelect)
      object.setmetadata(anno, "url", url)
    end
  end
  return true
end

-- Filter parameters are used to extract exactly what we want
-- from API requests. Here, we request four pieces of data.
-- See the documentation to find out what parameters can be used.
t = { "data.caption.text", 
      "data.images.standard_resolution.url", 
      "data.location.latitude", 
      "data.location.longitude" }

--* This is the call we make to request photos from Instagram.
myInstagram = instagram.photos("tag", searchTerm, t, gotInstagram)

