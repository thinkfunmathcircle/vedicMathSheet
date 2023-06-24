import random

def main():
    int2d = [i for i in range(11, 99)]

    multi5 = [j for j in int2d if j % 10 == 5]

    square5 = [(i, i, i*i) for i in multi5]

    print(f"{int2d}")
    print(f"{multi5}")
    print(f"{square5}")

    multi2d = [(i,j) for i in int2d for j in int2d if i % 10 + j % 10 == 10]
    print(f"{multi2d}")


    multi2d1 = [(i,j) for i in int2d for j in int2d if (i % 10 + j % 10 == 10) and (i // 10 == j // 10)]
    # random.shuffle(multi2d1)
    print(f"{multi2d1}")


if __name__ == "__main__":
    main()
