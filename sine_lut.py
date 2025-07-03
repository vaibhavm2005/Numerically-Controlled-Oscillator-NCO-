import numpy as np

# Create 256 samples of a sine wave
samples = 256
amplitude = 127.5
offset = 127.5
sine_values = np.round(amplitude * np.sin(2 * np.pi * np.arange(samples) / samples) + offset).astype(int)

# Write to sine_lut.hex in hex format
with open("sine_lut.hex", "w") as f:
    for value in sine_values:
        f.write(f"{value:02X}\n")  # each value on a new line
