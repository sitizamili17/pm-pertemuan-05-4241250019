import 'package:material_ui/material_ui.dart';

/// Satu-satunya warna yang ditulis langsung: seed color tema (cokelat rendang).
const Color _warnaSeed = Color(0xFF7B2D12);

/// Font judul bergaya serif (tampil di Android; web bisa memakai font bawaan).
const String _fontJudul = 'serif';

/// Data satu menu.
class ItemMenu {
  const ItemMenu(this.nama, this.harga, this.kategori);

  final String nama;
  final int harga;
  final String kategori;
}

const List<ItemMenu> daftarMenu = [
  ItemMenu('Rendang Daging Sapi', 48000, 'Hidangan Utama'),
  ItemMenu('Nasi Rendang Komplit', 55000, 'Paket'),
  ItemMenu('Rendang Telur', 22000, 'Hidangan Utama'),
  ItemMenu('Teh Talua', 18000, 'Minuman'),
  ItemMenu('Kerupuk Jangek', 12000, 'Camilan'),
];

/// Mengubah 48000 menjadi "Rp48.000".
String _rupiah(int n) {
  final angka = n.toString().replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (m) => '.',
      );
  return 'Rp$angka';
}

/// Ikon menu berdasarkan kategorinya.
IconData _ikonKategori(String kategori) => switch (kategori) {
      'Hidangan Utama' => Icons.restaurant,
      'Paket' => Icons.lunch_dining,
      'Minuman' => Icons.local_cafe,
      'Camilan' => Icons.fastfood,
      _ => Icons.restaurant_menu,
    };

/// Bentuk kartu seragam: sudut melengkung dengan garis tepi halus.
RoundedRectangleBorder _bentukKartu(ColorScheme skema) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    side: BorderSide(color: skema.outlineVariant),
  );
}

/// Gaya judul bagian (serif, tebal).
TextStyle? _judulBagian(TextTheme teks) {
  return teks.titleLarge?.copyWith(
    fontFamily: _fontJudul,
    fontWeight: FontWeight.w700,
  );
}

void main() => runApp(const UmkmApp());

/// Akar aplikasi. Stateless: tema tidak berubah selama aplikasi berjalan.
class UmkmApp extends StatelessWidget {
  const UmkmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rendang Uni Sari',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _warnaSeed),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _warnaSeed,
          brightness: Brightness.dark,
        ),
      ),
      home: const HalamanMenu(),
    );
  }
}

/// Halaman utama. Stateless: hanya menyusun tampilan, tanpa data yang berubah.
class HalamanMenu extends StatelessWidget {
  const HalamanMenu({super.key});

  void _info(BuildContext context, String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pesan)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          // Lebar dibatasi supaya di layar lebar tetap seperti tampilan HP.
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar utama dengan label
                  ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: AspectRatio(
                      aspectRatio: 16 / 10,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/images/header.jpg',
                            fit: BoxFit.cover,
                            // Cadangan bila gambar tidak ditemukan
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: skema.primaryContainer,
                              child: Center(
                                child: Icon(
                                  Icons.restaurant,
                                  size: 64,
                                  color: skema.onPrimaryContainer,
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            top: 12,
                            left: 12,
                            child: Chip(
                              avatar: Icon(Icons.star_rounded, size: 18),
                              label: Text('Khas Minang'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Identitas usaha
                  Text(
                    'MASAKAN MINANG  ·  SEJAK 1998',
                    style: teks.labelMedium?.copyWith(
                      color: skema.primary,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rendang Uni Sari',
                    style: teks.headlineLarge?.copyWith(
                      fontFamily: _fontJudul,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 48,
                    height: 3,
                    decoration: BoxDecoration(
                      color: skema.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Rendang daging sapi dimasak perlahan berjam-jam dengan '
                    'santan kental dan rempah pilihan, sesuai resep warisan '
                    'keluarga.',
                    style: teks.bodyLarge?.copyWith(
                      color: skema.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Dua tombol aksi
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () =>
                              _info(context, 'Membuka WhatsApp (simulasi)'),
                          icon: const Icon(Icons.chat),
                          label: const Text('Pesan'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () =>
                              _info(context, 'Membuka peta (simulasi)'),
                          icon: const Icon(Icons.map_outlined),
                          label: const Text('Lokasi'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Kontak: Card + ListTile (3 baris)
                  Text('Hubungi Kami', style: _judulBagian(teks)),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    color: skema.surfaceContainerLow,
                    shape: _bentukKartu(skema),
                    child: const Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.phone_outlined),
                          title: Text('+62 812-3456-7890'),
                        ),
                        Divider(height: 1, indent: 16, endIndent: 16),
                        ListTile(
                          leading: Icon(Icons.email_outlined),
                          title: Text('halo@rendangunisari.example'),
                        ),
                        Divider(height: 1, indent: 16, endIndent: 16),
                        ListTile(
                          leading: Icon(Icons.location_on_outlined),
                          title: Text('Jl. Contoh No. 12, Medan'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Daftar menu
                  Text('Menu Pilihan', style: _judulBagian(teks)),
                  const SizedBox(height: 4),
                  Text(
                    'Ketuk ikon hati untuk menandai favorit',
                    style: teks.bodyMedium?.copyWith(
                      color: skema.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final item in daftarMenu)
                    KartuMenu(
                      nama: item.nama,
                      harga: item.harga,
                      kategori: item.kategori,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Satu kartu menu. Stateless: tampilannya hanya bergantung pada parameter.
class KartuMenu extends StatelessWidget {
  const KartuMenu({
    super.key,
    required this.nama,
    required this.harga,
    required this.kategori,
  });

  final String nama;
  final int harga;
  final String kategori;

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: skema.surfaceContainerLow,
      shape: _bentukKartu(skema),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Kotak ikon sesuai kategori
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: skema.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _ikonKategori(kategori),
                color: skema.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: teks.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _rupiah(harga),
                    style: teks.titleSmall?.copyWith(
                      color: skema.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(kategori),
                    visualDensity: VisualDensity.compact,
                    side: BorderSide.none,
                    backgroundColor: skema.secondaryContainer,
                    labelStyle: teks.labelMedium?.copyWith(
                      color: skema.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
            ),
            TombolFavorit(nama: nama),
          ],
        ),
      ),
    );
  }
}

/// Tombol favorit. Stateful: menyimpan status favorit yang berubah saat ditekan.
class TombolFavorit extends StatefulWidget {
  const TombolFavorit({super.key, required this.nama});

  final String nama;

  @override
  State<TombolFavorit> createState() => _TombolFavoritState();
}

class _TombolFavoritState extends State<TombolFavorit> {
  bool _favorit = false; // state: bertahan di objek State saat rebuild

  void _ubah() {
    setState(() => _favorit = !_favorit);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _favorit
              ? '${widget.nama} ditambahkan ke favorit'
              : '${widget.nama} dihapus dari favorit',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;

    return IconButton.filledTonal(
      onPressed: _ubah,
      tooltip: _favorit ? 'Hapus dari favorit' : 'Tambah ke favorit',
      icon: Icon(
        _favorit ? Icons.favorite : Icons.favorite_border,
        color: _favorit ? skema.error : null,
      ),
    );
  }
}