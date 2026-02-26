from typing import List
from random import randint
from time import time_ns
import argparse

MAX_INT = 100

def mergesort(list: List[int]) -> List[int]:
    if len(list) == 1:
        return list

    mid = len(list) // 2
    left = list[:mid]
    right = list[mid:]

    left = mergesort(left)
    right = mergesort(right)

    return merge(left, right)

def merge(left: List[int], right: List[int]) -> List[int]:
    out = []
    leftPos = 0
    rightPos = 0

    while leftPos != len(left) and rightPos != len(right):
        if left[leftPos] < right[rightPos]:
            out.append(left[leftPos])
            leftPos += 1
        else:
            out.append(right[rightPos])
            rightPos += 1


    if leftPos != len(left):
        out.extend(left[leftPos:])
    if rightPos != len(right):
        out.extend(right[rightPos:])

    return out

def create_array(n: int) -> List[int]:
    data = [0] * n

    for i in range(n):
        data[i] = randint(0, MAX_INT)
 
    return data

def time_sort(data: List[int], iterations: int) -> int:
    start = time_ns();
    tmp = data.copy() 

    for _ in range(iterations):
        data = mergesort(data)
        data = tmp.copy()


    return time_ns() - start

def write_time(elapsed: float, n: int, fileName: str) -> None:
    if fileName == None or fileName == "":
        print(f"{n}:\t{elapsed}") 
        return

    with open(fileName, "a") as file:
        out = f"{n}, {elapsed}\n"
        file.write(out)

def setup_args() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser()

    parser.add_argument("-l", "--lower", type=int, required=True)
    parser.add_argument("-u", "--upper", type=int, required=True)
    parser.add_argument("-s", "--step", type=int, required=True)
    parser.add_argument("-i", "--iter", type=int, required=True)
    parser.add_argument("-o", "--out", type=str, required=False)

    return parser

if __name__ == "__main__":
    parser = setup_args()
    args = parser.parse_args()

    if args.out != None:
        with open(args.out, "w") as f:
            f.close()
    
    for n in range(args.lower, args.upper + 1, args.step):
        data = create_array(n) 
        elapsed = time_sort(data, args.iter)
        elapsed = elapsed/args.iter
        write_time(elapsed, n, args.out)
