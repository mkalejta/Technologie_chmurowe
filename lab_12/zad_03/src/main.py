import platform

def main():
    os_type = platform.system()
    if os_type == "Windows":
        print("Witaj w aplikacji konsolowej na Windows!")
    else:
        print("Witaj w aplikacji konsolowej na Linux!")

if __name__ == "__main__":
    main()