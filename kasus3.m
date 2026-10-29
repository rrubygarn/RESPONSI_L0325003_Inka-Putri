%L0325003-Inka Putri

function Kasus3()
  persamaan = @(r) (4/3) * pi * r.^3 - 300;
  r = linspace(0, 10, 100);
  hasil = persamaan(r);
  plot(r, hasil);
  hold on;
  plot(r, zeros(size(r)), 'r');
  grid on;
  xlabel('r (cm)');
  ylabel('f(r)');
  title('f(r) = (4/3)*pi*r^3 - 300');
  hold off;

  batasBawah = 4;     % dari grafik, akar berada di antara 4 dan 5
  batasAtas = 5;
  fprintf('Perhitungan menggunakan metode Biseksi\n');
  hasilBiseksi = Biseksi(persamaan, batasBawah, batasAtas, 50, 0.000001);
  fprintf('Nilai akar metode Biseksi = %.6f\n\n', hasilBiseksi);
  fprintf('Perhitungan menggunakan metode Regulasi Falsi\n');
  hasilRegulasiFalsi = RegulasiFalsi(persamaan, batasBawah, batasAtas, 50, 0.000001);
  fprintf('Nilai akar metode Regulasi Falsi = %.6f\n\n', hasilRegulasiFalsi);

  jari = hasilBiseksi;
  vBola = (4/3) * pi * jari^3;
  vTabung = pi * jari^2 * (2 * jari);
  vLuar = vTabung - vBola;
  fprintf('Jari-jari bola & tabung = %.6f cm\n', jari);
  fprintf('Tinggi tabung           = %.6f cm\n', 2 * jari);
  fprintf('Volume bola             = %.6f cm^3\n', vBola);
  fprintf('Volume tabung           = %.6f cm^3\n', vTabung);
  fprintf('Volume tabung di luar bola = %.6f cm^3\n', vLuar);
end

%Biseksi
function titikTengah = Biseksi(persamaan, batasBawah, batasAtas, maksIterasi, toleransi)
  tic;
  nilaiBawah = persamaan(batasBawah);
  nilaiAtas = persamaan(batasAtas);
  if nilaiBawah * nilaiAtas > 0
    error('Warning: Nilai batas memiliki tanda yang sama.');
  end
  fprintf('Iter\ta\t\tb\t\tfa\t\tfb\t\tc\t\tfc\t\terr\n');
  for iterasi = 1:maksIterasi
    titikTengah = (batasBawah + batasAtas) / 2;
    nilaiTengah = persamaan(titikTengah);
    galat = abs(batasAtas - batasBawah) / 2;
    fprintf('%d\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n', iterasi, batasBawah, batasAtas, ...
            nilaiBawah, nilaiAtas, titikTengah, nilaiTengah, galat);
    if galat <= toleransi || nilaiTengah == 0
      break;
    end
    if nilaiBawah * nilaiTengah < 0
      batasAtas = titikTengah;
      nilaiAtas = nilaiTengah;
    else
      batasBawah = titikTengah;
      nilaiBawah = nilaiTengah;
    end
  end
  toc;
end

%Regulasi Falsi
function titikBaru = RegulasiFalsi(persamaan, batasBawah, batasAtas, maksIterasi, toleransi)
  tic;
  nilaiBawah = persamaan(batasBawah);
  nilaiAtas = persamaan(batasAtas);
  if nilaiBawah * nilaiAtas > 0
    error('Warning: Nilai batas memiliki tanda yang sama.');
  end
  fprintf('Iter\ta\t\tb\t\tfa\t\tfb\t\tc\t\tfc\t\terr\n');
  titikLama = batasBawah;
  for iterasi = 1:maksIterasi
    titikBaru = (batasBawah * nilaiAtas - batasAtas * nilaiBawah) / (nilaiAtas - nilaiBawah);
    nilaiBaru = persamaan(titikBaru);
    if iterasi == 1
      galat = abs(batasAtas - batasBawah);
    else
      galat = abs(titikBaru - titikLama);
    end
    fprintf('%d\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n', iterasi, batasBawah, batasAtas, ...
            nilaiBawah, nilaiAtas, titikBaru, nilaiBaru, galat);
    if abs(nilaiBaru) <= toleransi || (iterasi > 1 && galat <= toleransi)
      break;
    end
    if nilaiBawah * nilaiBaru < 0
      batasAtas = titikBaru;
      nilaiAtas = nilaiBaru;
    else
      batasBawah = titikBaru;
      nilaiBawah = nilaiBaru;
    end
    titikLama = titikBaru;
  end
  toc;
end
