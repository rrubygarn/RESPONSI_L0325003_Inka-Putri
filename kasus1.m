%L0325003_Inka Putri

function Kasus1()
  lambda = 12; v = 36; x = 10; h0 = 5;
  t = linspace(0, factorial(5), 1000);        % 0 <= t <= 5! = 120
  eksak = hitungNilaiEksak(t, h0, v, lambda, x);          % hitung nilai eksak
  hasil_n23 = hitungPendekatan(t, h0, v, lambda, x, 23);
  hasil_n24 = hitungPendekatan(t, h0, v, lambda, x, 24);
  hasil_n25 = hitungPendekatan(t, h0, v, lambda, x, 25);
  tampilkanHasil(eksak, hasil_n23, hasil_n24, hasil_n25); % menampilkan hasil

  figure;
  hold on;
  plot(t, eksak, 'r');
  plot(t, hasil_n23, 'g');
  plot(t, hasil_n24, 'y');
  plot(t, hasil_n25, 'b');
  aturGrafik(eksak);
  hold off;

  figure;
  semilogy(t(2:end), abs(eksak(2:end) - hasil_n23(2:end)), 'g'); hold on;
  semilogy(t(2:end), abs(eksak(2:end) - hasil_n24(2:end)), 'y');
  semilogy(t(2:end), abs(eksak(2:end) - hasil_n25(2:end)), 'b');
  grid on; xlabel('t'); ylabel('galat mutlak');
  legend('Error N=23', 'Error N=24', 'Error N=25', 'location', 'northwest');
  hold off;
end

function eksak = hitungNilaiEksak(t, h0, v, lambda, x)
  eksak = h0 * (cos((t * v) / lambda) + exp(x));
end

function hasil = hitungPendekatan(t, h0, v, lambda, x, n)
  y = (t * v) / lambda;
  deret_cos = 0;
  deret_exp = 0;
  for i = 0:(n-1)
    deret_cos = deret_cos + (-1)^i * (y.^(2*i)) / factorial(2*i);
    deret_exp = deret_exp + (x^i) / factorial(i);
  end
  hasil = h0 * (deret_cos + deret_exp);
end

function tampilkanHasil(eksak, n23, n24, n25)
  fprintf('\n--- Hasil ---\n');
  fprintf('Nilai Eksak     : %.6f\n', mean(eksak));
  fprintf('Pendekatan_n23  : %.6e\n', mean(n23));
  fprintf('Pendekatan_n24  : %.6e\n', mean(n24));
  fprintf('Pendekatan_n25  : %.6e\n', mean(n25));

  error_n23 = abs(eksak - n23);
  error_n24 = abs(eksak - n24);
  error_n25 = abs(eksak - n25);
  fprintf('\nError_n23       : %.6e\n', mean(error_n23));
  fprintf('Error_n24       : %.6e\n', mean(error_n24));
  fprintf('Error_n25       : %.6e\n', mean(error_n25));

  galat = [mean(error_n23), mean(error_n24), mean(error_n25)];
  relatif = mean(galat) / mean(eksak);
  fprintf('\nError rata-rata : %.6e\n', mean(galat));
  fprintf('Error relatif   : %.6e (%.6e %%)\n', relatif, relatif * 100);

  toleransi = 0.01;                                   % batas toleransi 1%
  if (relatif <= toleransi)
    fprintf('Metode pendekatan LAYAK digunakan.\n');
  else
    fprintf('Metode pendekatan TIDAK LAYAK digunakan.\n');
  end
end

function aturGrafik(eksak)
  grid on;
  xlabel('t');
  ylabel('h');
  title('h = h0(cos(tv/lambda)+e^x)', 'Fontsize', 12);
  batas = 0.3 * (max(eksak) - min(eksak)) + 1;
  ylim([min(eksak) - batas, max(eksak) + batas]);     % fokus pada kurva eksak
  legend('Nilai Eksak', 'N=23', 'N=24', 'N=25', 'location', 'northwest');
end
