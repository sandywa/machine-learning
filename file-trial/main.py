import pandas as pd
import numpy as np
import scipy as sc

def getNeighbors(objID, K):

    distances = []
    for temp in objDict:
        if (temp != objID):
            dist = ComputeDistance(objDict[objID], objDict[temp])
            distances.append((temp, dist))
    distances.sort(key=operator.itemgetter(1))

    neighbors = []
    for x in range(K):
        neighbors.append((distances[x][0], distances[x][1]))
    return neighbors

def ComputeDistance(a, b):
    dataA = a[1]
    dataB = b[1]

    AttributeDistance = spatial.distance.cosine(dataA, dataB)

    return AttributeDistance

pd_df = pd.read_csv('data-citrus.csv')
pd_df0 = pd_df.iloc[0 : 4]
print(pd_df0)
df_array = pd_df0.to_numpy() #convert to numpy array

objDict = {}

for d in df_array:
    objID = int(d[0])
    name = d[4]
    attributes = d[1:3]
    attributes = map(int, attributes)
    objDict[objID] = (name, np.array(list(attributes)))

K = 10
selectedID = 5

print("selected obj:", objDict[selectedID][0])

neighbors = getNeighbors(selectedID, K)

for neighbor in neighbors:
    print(str(neighbor[0]) + " | " + objDict[neighbor[0]][0] + " | " + str(neighbor[1]))