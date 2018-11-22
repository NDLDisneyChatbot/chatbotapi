from sklearn.cluster import KMeans
import numpy as np
import argparse
import ast
from sys import argv
def getCluster(data):
    #data = map(float, data.strip('[]').split(','))
    data = buildList(data)
    #print(data)
    X = np.array(data)
    #print(X)
    kmeans = KMeans(n_clusters=5, random_state=0).fit(X)

    centers = sorted(kmeans.cluster_centers_, key=lambda x: x[-1])
    for index, center in enumerate(centers):
        centers[index] = center.tolist()

    centers = centers[::-1]
    print(centers)
    return centers

def buildList(st):
    st = st[1:-1]
    fi = 0
    ans = list()
    for i,e in enumerate(st):
        if e == '[':
            fi = i
        elif e == ']':
            ans.append(list(map(float, st[fi+1:i].split(','))))
    return ans

if __name__ == '__main__':
    getCluster(argv[1])

