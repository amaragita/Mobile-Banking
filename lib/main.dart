import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() {
  String username = usernameController.text;
  String password = passwordController.text;

  // Validasi apakah username dan password hanya angka
  if (RegExp(r'^\d+$').hasMatch(username) &&
      RegExp(r'^\d+$').hasMatch(password) &&
      username == password &&
      username.isNotEmpty) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(username: username), // Kirim username
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Username atau password salah!')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Koperasi Undiksha',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.blue[800],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Logo_undiksha.png/640px-Logo_undiksha.png',
                width: 150,
                height: 150,
              ), // Ensure this path is correct
              SizedBox(height: 60), // Add spacing between logo and form
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800], // Dark blue color
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Daftar Mbanking'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Lupa password?'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String username; // Tambahkan parameter username

  HomePage({required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double saldo = 1200000; // Saldo awal pengguna
  List<Map<String, dynamic>> mutasi = []; // List untuk menyimpan histori transfer

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Koperasi Undiksha',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
        backgroundColor: Colors.blue[800],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tampilkan nama dan foto pengguna
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://raw.githubusercontent.com/amaragita/Tugas-Layout-1/main/Foto%204x6.png',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                title: Text('Nasabah', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Luh Putu Amaragita Tiarani Wicaya'), // Nama tetap ada
                    SizedBox(height: 5),
                    Text('Total Saldo Anda', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Rp. ${saldo.toStringAsFixed(0)}'), // Saldo dinamis
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Menu Grid
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildMenuItem(context, Icons.account_balance_wallet, 'Cek Saldo', CekSaldoPage(saldo: saldo)),
                _buildMenuItem(context, Icons.sync_alt, 'Transfer', TransferPage(onTransfer: _updateSaldo)),
                _buildMenuItem(context, Icons.savings, 'Deposito', DepositoPage()),
                _buildMenuItem(
                  context,
                  Icons.payment,
                  'Pembayaran',
                  PembayaranPage(onPayment: _updateSaldoPembayaran),
                ),
                _buildMenuItem(context, Icons.business_center, 'Pinjaman', PinjamanPage()),
                _buildMenuItem(context, Icons.receipt, 'Mutasi', MutasiPage(mutasi: mutasi)),
              ],
            ),
            SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    // Ikon telepon
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.phone,
                        color: Colors.blue[800],
                        size: 30,
                      ),
                    ),
                    SizedBox(width: 15),
                    // Informasi teks
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Butuh Bantuan?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Hubungi kami di nomor berikut:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '089123456789',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.blue[800]),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code, color: Colors.blue[800]),
            label: 'QR Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blue[800]),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.blue[800],
        onTap: (index) {
          if (index == 0) { // Jika tombol Setting diklik
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingPage(), // Pindah ke halaman SettingPage
              ),
            );
          } else if (index == 2) { // Jika tombol Profile diklik
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(username: widget.username), // Kirim username ke ProfilePage
              ),
            );
          }
        },
      ),
    );
  }

  // Fungsi untuk memperbarui saldo
  void _updateSaldo(double jumlahTransfer) {
  if (jumlahTransfer > saldo) {
    // Jika jumlah transfer lebih besar dari saldo, tampilkan notifikasi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saldo Anda tidak mencukupi!')),
    );
  } else {
    // Jika saldo mencukupi, kurangi saldo dan tambahkan ke mutasi
    setState(() {
      saldo -= jumlahTransfer; // Kurangi saldo sesuai jumlah transfer
      mutasi.add({
        'tanggal': DateTime.now(), // Simpan tanggal transfer
        'jumlah': jumlahTransfer, // Simpan jumlah transfer
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Transfer berhasil!')),
    );
  }
}

  void _updateSaldoAndMutasi(double jumlahPembayaran, String nomorTagihan) {
  if (jumlahPembayaran > saldo) {
    // Jika jumlah pembayaran lebih besar dari saldo, tampilkan notifikasi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saldo Anda tidak mencukupi!')),
    );
  } else {
    // Jika saldo mencukupi, kurangi saldo dan tambahkan ke mutasi
    setState(() {
      saldo -= jumlahPembayaran; // Kurangi saldo sesuai jumlah pembayaran
      mutasi.add({
        'tanggal': DateTime.now(), // Simpan tanggal pembayaran
        'jumlah': jumlahPembayaran, // Simpan jumlah pembayaran
        'nomorTagihan': nomorTagihan, // Simpan nomor tagihan
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pembayaran berhasil!')),
    );
  }
}

  void _updateSaldoPembayaran(double jumlahPembayaran, String nomorTagihan) {
  if (jumlahPembayaran > saldo) {
    // Jika jumlah pembayaran lebih besar dari saldo, tampilkan notifikasi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saldo Anda tidak mencukupi!')),
    );
  } else {
    // Jika saldo mencukupi, kurangi saldo dan tambahkan ke mutasi
    setState(() {
      saldo -= jumlahPembayaran; // Kurangi saldo sesuai jumlah pembayaran
      mutasi.add({
        'tanggal': DateTime.now(), // Simpan tanggal pembayaran
        'jumlah': jumlahPembayaran, // Simpan jumlah pembayaran
        'keterangan': 'Pembayaran Tagihan: $nomorTagihan', // Tambahkan keterangan
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pembayaran berhasil!')),
    );
  }
}

  Widget _buildMenuItem(BuildContext context, IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.blue[800]),
          SizedBox(height: 5),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class CekSaldoPage extends StatelessWidget {
  final double saldo; // Tambahkan parameter saldo

  CekSaldoPage({required this.saldo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cek Saldo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Saldo Anda Saat Ini:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Rp. ${saldo.toStringAsFixed(0)}', // Tampilkan saldo yang diterima
              style: TextStyle(fontSize: 24, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}

class TransferPage extends StatefulWidget {
  final Function(double) onTransfer;

  TransferPage({required this.onTransfer});

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transfer')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Jumlah Transfer', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double jumlahTransfer = double.tryParse(_amountController.text) ?? 0;
                if (jumlahTransfer > 0) {
                  widget.onTransfer(jumlahTransfer); // Panggil fungsi untuk mengurangi saldo
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Masukkan jumlah transfer yang valid!')),
                  );
                }
              },
              child: Text('Kirim'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
            ),
          ],
        ),
      ),
    );
  }
}

class DepositoPage extends StatefulWidget {
  @override
  _DepositoPageState createState() => _DepositoPageState();
}

class _DepositoPageState extends State<DepositoPage> {
  String? _selectedDuration;
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deposito'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Jangka Waktu Deposito:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedDuration,
              items: ['3 Bulan', '6 Bulan', '12 Bulan']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDuration = value;
                });
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Jumlah Deposito',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedDuration != null &&
                    _amountController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Deposito berhasil disimpan!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Harap lengkapi semua data!')),
                  );
                }
              },
              child: Text('Simpan'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
            ),
          ],
        ),
      ),
    );
  }
}

class PembayaranPage extends StatefulWidget {
  final Function(double, String) onPayment; // Tambahkan parameter onPayment

  PembayaranPage({required this.onPayment});

  @override
  _PembayaranPageState createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  final TextEditingController _billNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _billNumberController,
              decoration: InputDecoration(
                labelText: 'Nomor Tagihan',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Jumlah Pembayaran',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double jumlahPembayaran =
                    double.tryParse(_amountController.text) ?? 0;
                String nomorTagihan = _billNumberController.text;

                if (nomorTagihan.isNotEmpty && jumlahPembayaran > 0) {
                  widget.onPayment(jumlahPembayaran, nomorTagihan); // Panggil fungsi untuk memperbarui saldo dan mutasi
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Pembayaran berhasil dilakukan!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Harap lengkapi semua data!')),
                  );
                }
              },
              child: Text('Bayar'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
            ),
          ],
        ),
      ),
    );
  }
}

class PinjamanPage extends StatefulWidget {
  @override
  _PinjamanPageState createState() => _PinjamanPageState();
}

class _PinjamanPageState extends State<PinjamanPage> {
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _loanDurationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pinjaman'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _loanAmountController,
              decoration: InputDecoration(
                labelText: 'Jumlah Pinjaman',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _loanDurationController,
              decoration: InputDecoration(
                labelText: 'Jangka Waktu (bulan)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_loanAmountController.text.isNotEmpty &&
                    _loanDurationController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Pinjaman berhasil diajukan!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Harap lengkapi semua data!')),
                  );
                }
              },
              child: Text('Ajukan'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final String username;

  ProfilePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://raw.githubusercontent.com/amaragita/Tugas-Layout-1/main/Foto%204x6.png',
              ),
            ),
            SizedBox(height: 20),
            // Nama Nasabah
            Text(
              username, // Tetap menampilkan username dari login
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 10),
            // Informasi tambahan
            Text(
              'Luh Putu Amaragita Tiarani Wicaya',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 30),
            // Informasi Nomor Handphone
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.phone, color: Colors.blue[800]),
                title: Text('No. Handphone'),
                subtitle: Text('08977217561'),
              ),
            ),
            SizedBox(height: 10),
            // Informasi Email
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.email, color: Colors.blue[800]),
                title: Text('Email'),
                subtitle: Text('amaragita@student.undiksha.ac.id'),
              ),
            ),
            SizedBox(height: 10),
            // Informasi Versi Aplikasi
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.info, color: Colors.blue[800]),
                title: Text('Versi Aplikasi'),
                subtitle: Text('1.0.0'),
              ),
            ),
            SizedBox(height: 30),
            // Tombol Logout
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              icon: Icon(Icons.logout, color: Colors.white),
              label: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MutasiPage extends StatelessWidget {
  final List<Map<String, dynamic>> mutasi;

  MutasiPage({required this.mutasi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mutasi')),
      body: mutasi.isEmpty
          ? Center(
              child: Text(
                'Belum ada histori transaksi.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: mutasi.length,
              itemBuilder: (context, index) {
                final item = mutasi[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      item['keterangan'] ?? 'Transaksi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Tanggal: ${item['tanggal'].toString().split('.')[0]}',
                    ),
                    trailing: Text(
                      '- Rp. ${item['jumlah'].toStringAsFixed(0)}',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Pengaturan Umum',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 20),
            // Notifikasi
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: SwitchListTile(
                value: true, // Default value
                onChanged: (value) {
                  // Tambahkan logika untuk mengaktifkan/mematikan notifikasi
                },
                title: Text('Notifikasi'),
                subtitle: Text('Aktifkan atau nonaktifkan notifikasi'),
                activeColor: Colors.blue[800],
              ),
            ),
            SizedBox(height: 10),
            // Tema Aplikasi
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.color_lens, color: Colors.blue[800]),
                title: Text('Tema Aplikasi'),
                subtitle: Text('Ubah tema aplikasi'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue[800]),
                onTap: () {
                  // Tambahkan logika untuk mengubah tema
                },
              ),
            ),
            SizedBox(height: 10),
            // Bahasa
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.language, color: Colors.blue[800]),
                title: Text('Bahasa'),
                subtitle: Text('Pilih bahasa aplikasi'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue[800]),
                onTap: () {
                  // Tambahkan logika untuk mengubah bahasa
                },
              ),
            ),
            SizedBox(height: 10),
            // Tentang Aplikasi
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.info, color: Colors.blue[800]),
                title: Text('Tentang Aplikasi'),
                subtitle: Text('Informasi tentang aplikasi'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue[800]),
                onTap: () {
                  // Tambahkan logika untuk menampilkan informasi aplikasi
                },
              ),
            ),
            SizedBox(height: 30),
            // Tombol Simpan
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Tambahkan logika untuk menyimpan pengaturan
                },
                icon: Icon(Icons.save, color: Colors.white),
                label: Text(
                  'Simpan Pengaturan',
                  style: TextStyle(color: Colors.white), // Ubah warna teks menjadi putih
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

