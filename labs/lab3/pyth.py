import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import firwin, butter, lfilter, freqz, spectrogram
from scipy.io.wavfile import write
import os

# ============================================================
# SETTINGS
# ============================================================
fs = 44100            # Sampling rate
duration = 5.0        # Seconds
t = np.linspace(0, int(fs*duration), int(fs*duration), endpoint=False)

# ============================================================
# 1) CREATE TEST SIGNAL (clean + noise + hum)
# ============================================================
sig_clean = 0.6*np.sin(2*np.pi*440*t) + 0.3*np.sin(2*np.pi*1200*t)
hum = 0.2*np.sin(2*np.pi*50*t)
noise = 0.25 * np.random.normal(0, 1, len(t))

sig_noisy = sig_clean + hum + noise

# ============================================================
# 2) DESIGN FIR FILTERS
# ============================================================

# FIR Notch (bandstop) around 50 Hz
numtaps = 801
notch_bw = 2.0
low = (50 - notch_bw) / (fs/2)
high = (50 + notch_bw) / (fs/2)
fir_notch = firwin(numtaps, [low, high], pass_zero=True)

# FIR Lowpass at 6 kHz
cut_lp = 6000
fir_lowpass = firwin(401, cut_lp, fs=fs)


# ============================================================
# 3) DESIGN IIR FILTERS (Butterworth)
# ============================================================
b_iir_notch, a_iir_notch = butter(
    4, [(50-3)/(fs/2), (50+3)/(fs/2)], btype='bandstop'
)

b_iir_lp, a_iir_lp = butter(
    6, cut_lp/(fs/2), btype='low'
)


# ============================================================
# 4) APPLY FILTERS
# ============================================================
# FIR chain
y_fir_notch = lfilter(fir_notch, [1.0], sig_noisy)
y_fir_lp = lfilter(fir_lowpass, [1.0], sig_noisy)
y_fir_chain = lfilter(fir_lowpass, [1.0], y_fir_notch)

# IIR chain
y_iir_notch = lfilter(b_iir_notch, a_iir_notch, sig_noisy)
y_iir_lp = lfilter(b_iir_lp, a_iir_lp, sig_noisy)
y_iir_chain = lfilter(b_iir_lp, a_iir_lp, y_iir_notch)


# ============================================================
# 5) PLOTTING FUNCTIONS
# ============================================================
def plot_time(x, title, max_samples=2000):
    plt.figure(figsize=(7,3))
    plt.plot(x[:max_samples])
    plt.title(title)
    plt.xlabel("Samples")
    plt.ylabel("Amplitude")
    plt.grid(True)
    plt.tight_layout()
    plt.show()

def plot_freq_response(b, a=1, title="Frequency Response"):
    w, h = freqz(b, a, worN=8192)
    freqs = w * fs / (2*np.pi)
    plt.figure(figsize=(7,3))
    plt.semilogx(freqs, 20*np.log10(np.abs(h) + 1e-12))
    plt.title(title)
    plt.xlabel("Frequency (Hz)")
    plt.ylabel("Magnitude (dB)")
    plt.grid(True, which='both')
    plt.tight_layout()
    plt.show()

def plot_spec(x, title):
    f, tt, Sxx = spectrogram(x, fs=fs, nperseg=1024)
    plt.figure(figsize=(7,3))
    plt.pcolormesh(tt, f, 10*np.log10(Sxx+1e-12), shading='gouraud')
    plt.title(title)
    plt.ylabel("Frequency (Hz)")
    plt.xlabel("Time (s)")
    plt.ylim(0, 8000)
    plt.colorbar(label="dB")
    plt.tight_layout()
    plt.show()


# ============================================================
# 6) SHOW PLOTS
# ============================================================

plot_time(sig_noisy, "Noisy Signal - Time Domain")
plot_spec(sig_noisy, "Noisy Signal — Spectrogram")

plot_freq_response(fir_notch, title="FIR Notch 50Hz (bandstop)")
plot_freq_response(fir_lowpass, title="FIR Lowpass 6kHz")

plot_freq_response(b_iir_notch, a_iir_notch, title="IIR Notch 50Hz")
plot_freq_response(b_iir_lp, a_iir_lp, title="IIR Lowpass 6kHz")

plot_time(y_fir_chain, "FIR Denoised (Notch + LP)")
plot_time(y_iir_chain, "IIR Denoised (Notch + LP)")

plot_spec(y_fir_chain, "FIR Denoised — Spectrogram")
plot_spec(y_iir_chain, "IIR Denoised — Spectrogram")


# ============================================================
# 7) SAVE WAV FILES
# ============================================================
os.makedirs("dsp_output", exist_ok=True)

def save_wav(x, filename):
    x = x / (np.max(np.abs(x)) + 1e-12)
    write(f"dsp_output/{filename}", fs, (x * 32767).astype(np.int16))

save_wav(sig_clean, "clean_reference.wav")
save_wav(sig_noisy, "noisy_input.wav")
save_wav(y_fir_chain, "denoised_fir.wav")
save_wav(y_iir_chain, "denoised_iir.wav")

print("WAV files saved in folder: dsp_output/")