from PIL import Image, ImageDraw, ImageFont

characters = "$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft()1{}[]?_+~<>i!lI;:\",^`'."
edges = "\\|/-"

pixel_size = 40

def generate(characters,fname):
  print("Generating image with {} characters and pixel size of {}".format(len(characters), pixel_size))

  # Create an empty black image
  img_width, img_height = len(characters) * pixel_size, pixel_size
  image = Image.new('1', (img_width, img_height), 0)  # '1' mode for 1-bit pixels (black and white), '0' for black background
  draw = ImageDraw.Draw(image)

  # Load a monospaced bitmap font (for pixel-perfect rendering)
  try:
      font = ImageFont.truetype("dogicabold.otf", pixel_size)
  except IOError:
      font = ImageFont.load_default()

  # Define text and positions
  start_x, start_y = 0, 0  # Starting position
  spacing = pixel_size  # Space between characters

  for index, char in enumerate(characters):
      x = start_x + index * spacing
      draw.text((x, start_y), char, fill=1, font=font)  # '1' for white

  # Save the image
  image.save(fname)

generate(characters, "../../textures/character_fill.png")
generate(edges, "../../textures/character_edges.png")