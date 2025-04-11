import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0, 10, 100)
y = np.sin(x)

plt.figure(figsize=(8, 4))
plt.plot(x, y, label="sin(x)", color="blue")
plt.xlabel("X")
plt.ylabel("Y")
plt.title("Wykres funkcji sinus")
plt.legend()

plt.savefig("wykres.png")
print("Wykres został zapisany jako wykres.png")