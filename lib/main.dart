import 'package:material_ui/material_ui.dart';

/// Satu-satunya warna yang ditulis langsung: seed color tema (perunggu rendang).
const Color _warnaSeed = Color(0xFF8B5A2B);

/// Font judul bergaya serif (tampil jelas di Android).
const String _fontJudul = 'serif';

/// Data satu menu.
class ItemMenu {
  const ItemMenu(this.nama, this.harga, this.kategori, this.deskripsi);

  final String nama;
  final int harga;
  final String kategori;
  final String deskripsi;
}

const List<ItemMenu> daftarMenu = [
  ItemMenu(
    'Rendang Daging Sapi',
    48000,
    'Hidangan Utama',
    'Dimasak berjam-jam dengan santan kental dan rempah pilihan.',
  ),
  ItemMenu(
    'Nasi Rendang Komplit',
    55000,
    'Paket',
    'Rendang, nasi putih, daun singkong, dan sambal hijau.',
  ),
  ItemMenu(
    'Rendang Telur',
    22000,
    'Hidangan Utama',
    'Telur rebus berbumbu rendang, gurih dan pedas.',
  ),
  ItemMenu(
    'Teh Talua',
    18000,
    'Minuman',
    'Teh hangat dengan kuning telur dan jeruk nipis.',
  ),
  ItemMenu(
    'Kerupuk Jangek',
    12000,
    'Camilan',
    'Kerupuk kulit renyah, pendamping rendang.',
  ),
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
    borderRadius: BorderRadius.circular(24),
    side: BorderSide(color: skema.outlineVariant),
  );
}

/// Ornamen pemisah: garis, berlian kecil, garis.
Widget _ornamen(ColorScheme skema) {
  return Row(
    children: [
      Expanded(child: Divider(color: skema.outlineVariant)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Icon(Icons.diamond_outlined, size: 14, color: skema.primary),
      ),
      Expanded(child: Divider(color: skema.outlineVariant)),
    ],
  );
}

/// Judul bagian dengan keterangan opsional (parameter bernama).
Widget _judulBagian(BuildContext context, String judul, {String? keterangan}) {
  final skema = Theme.of(context).colorScheme;
  final teks = Theme.of(context).textTheme;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        judul,
        style: teks.titleLarge?.copyWith(
          fontFamily: _fontJudul,
          fontWeight: FontWeight.w700,
        ),
      ),
      if (keterangan != null)
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            keterangan,
            style: teks.bodyMedium?.copyWith(color: skema.onSurfaceVariant),
          ),
        ),
    ],
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(pesan)));
  }

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Menu UMKM Kuliner')),
      body: SafeArea(
        bottom: false,
        child: Center(
          // Lebar dibatasi supaya di layar lebar tetap seperti tampilan HP.
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kepala: gambar penuh lebar, memudar ke warna latar
                  SizedBox(
                    height: 340,
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
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.4, 1.0],
                              colors: [
                                skema.surface.withValues(alpha: 0),
                                skema.surface,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          left: 20,
                          child: Chip(
                            avatar: Icon(
                              Icons.star_rounded,
                              size: 18,
                              color: skema.primary,
                            ),
                            label: const Text('Khas Minang'),
                            backgroundColor: skema.surface,
                            side: BorderSide.none,
                          ),
                        ),
                        Positioned(
                          left: 20,
                          right: 20,
                          bottom: 8,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'MASAKAN MINANG  ·  SEJAK 1998',
                                style: teks.labelMedium?.copyWith(
                                  color: skema.primary,
                                  letterSpacing: 3,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Rendang Uni Sari',
                                style: teks.headlineLarge?.copyWith(
                                  fontFamily: _fontJudul,
                                  fontWeight: FontWeight.w700,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Rating
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: skema.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '4,9',
                              style: teks.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '· 1.200+ ulasan',
                              style: teks.bodyMedium?.copyWith(
                                color: skema.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _ornamen(skema),
                        const SizedBox(height: 16),

                        // Deskripsi usaha
                        Text(
                          'Rendang daging sapi dimasak perlahan berjam-jam '
                          'dengan santan kental dan rempah pilihan, sesuai '
                          'resep warisan keluarga.',
                          style: teks.bodyLarge?.copyWith(
                            color: skema.onSurfaceVariant,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Dua tombol aksi
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: () => _info(
                                  context,
                                  'Membuka WhatsApp (simulasi)',
                                ),
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
                        const SizedBox(height: 32),

                        // Kontak: Card + ListTile (4 baris)
                        _judulBagian(context, 'Hubungi Kami'),
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
                                title: Text('rendangunisari@gmail.com'),
                              ),
                              Divider(height: 1, indent: 16, endIndent: 16),
                              ListTile(
                                leading: Icon(Icons.schedule_outlined),
                                title: Text('Setiap hari, 10.00 - 21.00 WIB'),
                              ),
                              Divider(height: 1, indent: 16, endIndent: 16),
                              ListTile(
                                leading: Icon(Icons.location_on_outlined),
                                title: Text('Jl. Surbakti No. 12, Medan'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Daftar menu
                        _judulBagian(
                          context,
                          'Menu Pilihan',
                          keterangan: 'Ketuk ikon hati untuk menandai favorit',
                        ),
                        const SizedBox(height: 16),
                        for (final item in daftarMenu)
                          KartuMenu(
                            nama: item.nama,
                            harga: item.harga,
                            kategori: item.kategori,
                            deskripsi: item.deskripsi,
                          ),
                        const SizedBox(height: 16),

                        // Penutup
                        _ornamen(skema),
                        const SizedBox(height: 12),
                        Center(
                          child: Text(
                            '© 2026 Rendang Uni Sari · Medan',
                            style: teks.labelSmall?.copyWith(
                              color: skema.onSurfaceVariant,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
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
    required this.deskripsi,
  });

  final String nama;
  final int harga;
  final String kategori;
  final String deskripsi;

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      color: skema.surfaceContainerLow,
      shape: _bentukKartu(skema),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ikon bulat sesuai kategori
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: skema.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _ikonKategori(kategori),
                color: skema.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: teks.titleMedium?.copyWith(
                      fontFamily: _fontJudul,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    deskripsi,
                    style: teks.bodySmall?.copyWith(
                      color: skema.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        _rupiah(harga),
                        style: teks.titleMedium?.copyWith(
                          fontFamily: _fontJudul,
                          color: skema.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
