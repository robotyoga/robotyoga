target = op('table_boxes')
gridSize = 10
unitSize = 0.02

target.clear()
target.appendRow(['tx', 'ty', 'tz'])

for i in range(0, 55):
  target.appendRow([0, 0, 0])

# halfGridSize = int(gridSize / 2)

# for y in range(-halfGridSize, halfGridSize):
#   for x in range(-halfGridSize, halfGridSize):
#     for z in range(-halfGridSize, halfGridSize):
#       if ((halfGridSize + x) + (halfGridSize + y) == (gridSize + (halfGridSize + z) - 1)):
#         target.appendRow([(x * unitSize), (y * unitSize), (z * unitSize)])




# filledSpace = {}

# fromCenter = 10
# count = 0
# while (fromCenter <= gridSize and count < 55):
#   # halfGridSize = int(math.ceil(fromCenter / 2))
#   # halfGridSize = int(math.floor(fromCenter / 2))
#   halfGridSize = int(fromCenter / 2)
#   for x in range(-halfGridSize, halfGridSize):
#     for y in range(-halfGridSize, halfGridSize):
#       for z in range(-halfGridSize, halfGridSize):
#         if ((halfGridSize + x) + (halfGridSize + y) == (fromCenter + (halfGridSize + z) - 1)):
#           spaceId = str(x) + ':' + str(y) + ':' + str(z)
#           if not filledSpace.get(spaceId, False):
#             # adjustedX = (x - (halfGridSize - fromCenter)) * unitSize
#             # adjustedX = (x + (halfGridSize - fromCenter)) * unitSize
#             adjustedX = (x) * unitSize
#             # adjustedY = (y - (halfGridSize - fromCenter)) * unitSize
#             # adjustedY = (y + (halfGridSize - fromCenter)) * unitSize
#             adjustedY = (y) * unitSize
#             # adjustedZ = (z - (halfGridSize - fromCenter)) * unitSize
#             # adjustedZ = (z + (halfGridSize - fromCenter)) * unitSize
#             adjustedZ = (z) * unitSize
#             target.appendRow([adjustedX, adjustedY, adjustedZ])
#             filledSpace[spaceId] = True
#             count += 1
#   fromCenter += 1



# fromOrigin = 0
# while fromOrigin <= (gridSize / 2):
#   # for x in range(-fromOrigin, fromOrigin):
#   adjustedX = fromOrigin * unitSize
#   adjustedY = fromOrigin * unitSize
#   adjustedZ = fromOrigin * unitSize
#   target.appendRow([adjustedX, adjustedY, adjustedZ])
#   target.appendRow([-adjustedX, -adjustedY, -adjustedZ])

#   fromOrigin += 1
# halfGridSize = gridSize / 2



# x = 0
# y = 0
# z = 0

# while x <= halfGridSize:
#   while y <= halfGridSize:
#     while z <= halfGridSize:
#       adjustedX = x * unitSize
#       adjustedY = y * unitSize
#       adjustedZ = z * unitSize
#       target.appendRow([adjustedX, adjustedY, adjustedZ])
#       target.appendRow([-adjustedX, -adjustedY, -adjustedZ])
#       z += 1
#     y += 1
#   x += 1


# def spiral(X, Y, Z):
#   x = y = z = 0
#   dx = 0
#   dy = -1
#   dz = -1
#   for i in range(max(X, Y, Z)**2):
#     if (-X/2 < x <= X/2) and (-Y/2 < y <= Y/2) and (-Z/2 < z <= Z/2):
#       if ((halfGridSize + x) + (halfGridSize + y) == (gridSize + (halfGridSize + z) - 1)):
#         adjustedX = x * unitSize
#         adjustedY = y * unitSize
#         adjustedZ = z * unitSize
#         target.appendRow([adjustedX, adjustedY, adjustedZ])
#         # target.appendRow([adjustedX, adjustedY, 0])
#       # DO STUFF...
#     if x == y or (x < 0 and x == -y) or (x > 0 and x == 1-y):
#       dx, dy = -dy, dx
#     x, y = x+dx, y+dy

# spiral(gridSize, gridSize, gridSize)






# def spiral(n):
#   half = n / 2
#   x = y = 0
#   dx = 0
#   dy = -1
#   for i in range(n ** 2):
#     if (-half < x <= half) and (-half < y <= half):
#       for z in range(int(-half), int(half)):
#         if ((half + x) + (half + y) == (n + (half + z) - 1)):
#           adjustedX = x * unitSize
#           adjustedY = y * unitSize
#           # adjustedZ = (y + x) * unitSize
#           adjustedZ = (z) * unitSize
#           target.appendRow([adjustedX, adjustedY, adjustedZ])
#       # DO STUFF...
#     if x == y or (x < 0 and x == -y) or (x > 0 and x == 1 - y):
#       dx, dy = -dy, dx
#     x, y = x+dx, y+dy

# spiral(gridSize)






# while (fromCenter < halfGridSize):
#   for z in range(-halfGridSize, halfGridSize):
#     for x in range(0, fromCenter):
#       for y in range(0, fromCenter):
#         if ((halfGridSize + x) + (halfGridSize + y) == (gridSize + (halfGridSize + z) - 1)):
#           target.appendRow([(x * unitSize), (y * unitSize), (z * unitSize)])
#     for x in range(fromCenter, 0):
#       for y in range(fromCenter, 0):
#         if ((halfGridSize + x) + (halfGridSize + y) == (gridSize + (halfGridSize + z) - 1)):
#           target.appendRow([(x * unitSize), (y * unitSize), (z * unitSize)])

#   fromCenter += 1
