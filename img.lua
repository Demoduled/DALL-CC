-- Import openai and quill
package.path = "/DALL-CC/?.lua;" .. package.path
local sketch = require("lib/sketch")

-- User input for risk and personality
local number, magnitude = ...
number = tonumber(number)

-- Input testing for non-number
if type(number) ~= "number" then
    number = 1
end
-- Input testing for out of range
if number < 1 then
    number = 1
elseif number > 10 then
    number = 10
end
-- Magnitude conversion, defaults to large
if magnitude then
    magnitude = string.lower(magnitude)
else
    magnitude = "lg"
end
local size
if magnitude == "sm" then
    size = "256x256"
elseif magnitude == "md" then
    size = "512x512"
elseif magnitude == "lg" then
    size = "1024x1024"
end


-- Printing chosen arguments
print('Number: ' .. number .. ' Size: "' .. size .. '"\n')


-- Read input
term.setTextColour(colours.red)
local prompt = read()
print("\n")
-- Prompt testing
if not prompt then
    error('Error: no prompt provided. Usage: img [number] [magnitude](sm, md, lg)')
end


-- Generate image
local link = sketch.generate(prompt, number, size)

-- Pull image
local req = http.get(link, nil, true)
local image = req.readAll()
-- TODO: use pngLua to render in ComputerCraft
req.close()

-- Print first link
term.setTextColour(colours.orange)
print(link)
term.setTextColour(colours.white)