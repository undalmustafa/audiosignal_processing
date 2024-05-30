% Örnekleme frekansı ve DFT uzunluğu
fs = 16000; % Örnekleme frekansı 16 kHz
T = 1/fs;
N = 1024;  % DFT Uzunluğu

%% SES KAYDI VE ANALİZİ
% Ses kaydetme ve gösterme
p = audiorecorder(fs, 16, 1);
disp('Ses kaydına başlamak için bir tuşa basın...');
pause;
disp('Kayıt başlıyor...');
recordblocking(p, 2); % 2 saniye kayıt
disp('Kayıt tamamlandı.');

% Kaydedilen veriyi alma
x = getaudiodata(p);
t = (0:length(x)-1)/(fs / 1000); % Zaman vektörünü milisaniye cinsine oluştur

% Kaydedilen sesin zaman domeninde gösterilmesi
figure;
subplot(3, 1, 1); % Üç grafik olacak şekilde düzenlendi
plot(t, x);
xlabel('Zaman (ms)');
ylabel('x(t)');
title('Kaydedilen Ses Sinyali');
grid on;

%% SES SİNYALİNİN DFT'SİNİ ALMA
X = fft(x, N);
f = (0:N-1)*(fs/N)/1000; % Frekans eksenini kHz cinsine oluştur

% Genlik spektrumunu hesapla
magnitude = abs(X);

% Genlik spektrumunu göster
subplot(3, 1, 2); % Üç grafik olacak şekilde düzenlendi
plot(f, magnitude);
xlabel('Frekans (kHz)');
ylabel('Genlik');
title('Kaydedilen Ses Sinyalinin Genlik Spektrumu');
grid on;

%% APPROXIMATE CONTINUOUS FOURIER TRANSFORM
% Sinyalin DFT'sini hesapla
X = fft(x);

% Frekans vektörü oluştur
N = length(X);
f = (-N/2:N/2-1)*(fs/N);

% DFT'yi ortala ve ölçeklendir
X_shifted = fftshift(X);
magnitude_shifted = abs(X_shifted)/N;

% Yaklaşık CFT grafiği
subplot(3, 1, 3);
plot(f, magnitude_shifted);
xlabel('Frekans (Hz)');
ylabel('|F(\omega)|');
title('Approximate Continuous Fourier Transform');
grid on;

%% PENCERELEME İLE SESİN BİR BÖLÜMÜNÜ ANALİZ ETME
xp = x(18000:19023); % Kayıt içinde sesin olduğu bölümden 1024 uzunluklu parça seç
figure;
plot(xp);
title('Pencereleme ile Seçilen Ses Bölümü');

% Pencere fonksiyonu tanımla ve DFT hesapla
win = hamming(length(xp)); % Hamming penceresi
X = abs(fft(xp .* win, N)); % Pencerelenen sinyalin DFT'si

% DFT'nin frekans domeninde gösterilmesi
f = (0:N-1)*(fs/N); % Frekans vektörü
figure;
plot(f(1:N/2), 20*log10(X(1:N/2))); % Yarı spektrum
xlabel('Frekans (Hz)');
ylabel('Genlik (dB)');
title('Pencerelenmiş Sinyalin DFTsi');
grid on;

% Sesin rezonanslarını bulmak için Doğrusal Öngörü Analizi (LPC)
ak = lpc(xp, 16); % LPC katsayıları
[H, F] = freqz(1, ak, 1024, fs);
hold on;
plot(F, 20*log10(abs(H)), 'r'); % Rezonansları göster
legend('Pencerelenmiş Sinyal', 'LPC');
title('Pencerelenmiş Sinyal ve LPC Analizi');

% DFT Katsayıları
n = 0:N-1; % Zaman
k = 0:N-1;
X = fft(x, N); % N Noktalı DFT hesapla
figure;
subplot(2, 1, 1);
stem(n, real(x));
xlabel('n');
ylabel('x[n]')
subplot(2, 1, 2);
stem(k, abs(X));
xlabel('DFT Katsayısı (k)');
ylabel('|X[k]|')

% w'yi frekans ekseninden hesapla
w = (0:N-1)*(fs/N) * 2 * pi; % rad/s cinsinden frekans ekseni

figure;
plot(w, 2*pi*abs(X)/N);
xlabel('Frekans (rad/s)');
ylabel('|X(w)|');

%% Temel frekans ve nota bulma (geliştirilmiş)
[~, idx] = max(X(1:N/2));
fundamental_freq = f(idx);

% Müzik notalarının frekansları (genişletilmiş ve çoklu oktav)
notes = {'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'};
frequencies = [];
for i = 0:7 % 8 oktav kontrol et
    frequencies = [frequencies 261.63*2^i 277.18*2^i 293.66*2^i 311.13*2^i 329.63*2^i 349.23*2^i 369.99*2^i 392.00*2^i 415.30*2^i 440.00*2^i 466.16*2^i 493.88*2^i]; 
end

% En yakın notayı bul
[~, note_idx] = min(abs(frequencies - fundamental_freq));
closest_note = notes{mod(note_idx-1, 12)+1}; % Nota adını bul
closest_freq = frequencies(note_idx); % En yakın frekans

disp(['Temel Frekans: ', num2str(fundamental_freq), ' Hz']);
disp(['En Yakın Nota: ', closest_note, ' (', num2str(closest_freq), ' Hz)']);

%% Grafikler

% En yakın nota frekans grafiği
figure;
stem(closest_freq, 1, 'ro');
xlabel('Frekans (Hz)');
ylabel('Genlik');
title(['En Yakın Nota: ', closest_note, ' (', num2str(closest_freq), ' Hz)']);
% Gürültülü sinyalin DTFT'si
figure;
plot(f/pi, 20*log10(abs(fft(x, N))));
xlabel('Normalize Frekans (w/pi)');
ylabel('DTFT (dB)');
title('Gürültülü Sinüzoidal Sinyalin DTFTgsi');