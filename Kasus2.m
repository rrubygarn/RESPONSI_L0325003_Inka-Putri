%L0325003-Inka Putri

function Kasus2()
  % Semua satuan sudah dikonversi ke kilogram
  % Kolom: beras, telur, tepung, ayam
  barang = [2.5  1.5   5    0.5;     % Adel
            4    0.75  1    2;       % Briza
            2    1.5   0.5  6;       % Caca
            1    4.25  2    0.9];    % Dinda
  harga = [161000; 149000; 251500; 173000];
  tolError = 0.000001;
  iterMaks = 100;

  fprintf('Percobaan 1: urutan baris asli\n');
  GaussSeidel(barang, harga, tolError, iterMaks);

  fprintf('\nPercobaan 2: urutan baris ditukar [2 4 1 3]\n');
  urutan = [2 4 1 3];
  x = GaussSeidel(barang(urutan,:), harga(urutan), tolError, iterMaks);
  cetakHarga(x);
  fprintf('Verifikasi max|Ax-b| = %.6e\n', max(abs(barang*x - harga)));
end

function x = GaussSeidel(A, b, tolError, iterMaks)
  n = length(b);
  dominan = true;
  for i = 1:n
    if abs(A(i,i)) <= sum(abs(A(i,:))) - abs(A(i,i))
      dominan = false;
    end
  end
  if dominan
    fprintf('Matriks dominan diagonal secara ketat\n');
  else
    fprintf('Matriks tidak dominan diagonal\n');
  end

  x = zeros(n,1);
  for k = 1:iterMaks
    xlama = x;
    for i = 1:n
      jumlah = A(i,:) * x - A(i,i) * x(i);
      x(i) = (b(i) - jumlah) / A(i,i);
    end
    selisih = max(abs(x - xlama));
    if k <= 3
      fprintf('Iterasi %d: %.4f  %.4f  %.4f  %.4f\n', k, x(1), x(2), x(3), x(4));
    end
    if selisih <= tolError
      fprintf('Iterasi %d: %.4f  %.4f  %.4f  %.4f\n', k, x(1), x(2), x(3), x(4));
      fprintf('Metode Gauss Seidel Konvergen pada iterasi ke-%d\n', k);
      return
    end
  end
  fprintf('Metode Gauss Seidel Tidak Konvergen\n');
end

function cetakHarga(x)
  fprintf('\nHarga/kg\n');
  fprintf('Harga Beras : %.2f\n', x(1));
  fprintf('Harga Telur : %.2f\n', x(2));
  fprintf('Harga Tepung: %.2f\n', x(3));
  fprintf('Harga Ayam  : %.2f\n', x(4));
end
