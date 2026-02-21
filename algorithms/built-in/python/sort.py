from typing import List
from random import randint
from time import time_ns
import argparse

MAX_INT = 2147483647

def create_array(n: int) -> List[int]:
    data = [0] * n

    for i in range(n):
        data[i] = randint(0, MAX_INT)
 
    return data

def time_sort(data: List[int], iterations: int) -> int:
    start = time_ns();
    tmp = data.copy() 

    for _ in range(iterations):
        data.sort()
        data = tmp.copy()


    return time_ns() - start

def write_time(elapsed: float, n: int, fileName: str) -> None:
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
    
    for n in range(args.lower, args.upper, args.step):
        data = create_array(n) 
        elapsed = time_sort(data, args.iter)

        if args.out != None:
            write_time(elapsed/args.iter, n, args.out)
        else:
            print(elapsed/args.iter, "ns", n)
