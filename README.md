# Musical Signal Processing: A MATLAB Implementation of DFT and LPC for Note and Harmonic Extraction

This MATLAB project was developed by Fatih Yüksel, Selçuk Aldemir and Mustafa Ündal as a course project for Digital Signal Processing [ELE-306] at Suleyman Demirel University. The project aims to provide a hands-on exploration of musical signal analysis using Discrete Fourier Transform (DFT) and Linear Predictive Coding (LPC) techniques.

## Key Features

* **Audio Recording:** Captures live audio input for analysis.
* **DFT Analysis:** Calculates and visualizes the frequency spectrum of the recorded audio.
* **Approximate Continuous Fourier Transform (CFT):** Provides an approximation of the continuous Fourier transform for deeper frequency analysis.
* **Windowing:** Enables analysis of specific segments of the audio using Hamming windowing.
* **LPC Analysis:** Identifies resonant frequencies (formants) in the audio signal, which are crucial for characterizing musical notes.
* **Fundamental Frequency and Note Identification:** Estimates the fundamental frequency of the note and suggests the closest musical note.
* **Visualization:** Generates informative plots for time-domain signals, frequency spectra, DFT coefficients, and more.

## How to Use

1. **Run the MATLAB script:** Execute the provided MATLAB script in your environment.
2. **Record Audio:** Follow the on-screen prompts to record a 2-second audio sample. 
3. **Analyze and Visualize:** The script will automatically perform the following:
   
   * Display the time-domain waveform of the recorded audio.
   * Calculate and plot the magnitude spectrum using DFT.
   * Compute and display the approximate continuous Fourier transform.
   * Select a portion of the audio for windowed analysis.
   * Apply a Hamming window and calculate the DFT of the windowed signal.
   * Perform LPC analysis to identify resonant frequencies.
   * Estimate the fundamental frequency and determine the closest musical note.
   * Generate additional plots for DFT coefficients and the DTFT of the noisy signal.

## Requirements

* MATLAB (with Signal Processing Toolbox)

## Additional Notes

* The project is designed for educational and exploratory purposes within the context of the [Signal Processing Course Name/Number].
* The accuracy of note identification depends on the quality of the audio recording and the complexity of the musical signal.
* Feel free to experiment with different audio samples and explore the effects of changing parameters like DFT length and LPC order.


