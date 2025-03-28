import 'package:flutter/material.dart';

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

    if (username == password && username.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
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

class HomePage extends StatelessWidget {
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
                    Text('Luh Putu Amaragita Tiarani Wicaya'),
                    SizedBox(height: 5),
                    Text('Total Saldo Anda', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Rp. 1.200.000'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildMenuItem(context, Icons.account_balance_wallet, 'Cek Saldo', CekSaldoPage()),
                _buildMenuItem(context, Icons.sync_alt, 'Transfer', TransferPage()),
                _buildMenuItem(context, Icons.savings, 'Deposito', DepositoPage()),
                _buildMenuItem(context, Icons.payment, 'Pembayaran', PembayaranPage()),
                _buildMenuItem(context, Icons.business_center, 'Pinjaman', PinjamanPage()),
                _buildMenuItem(context, Icons.receipt, 'Mutasi', MutasiPage()),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Butuh Bantuan?', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('08977217561', style: TextStyle(color: Colors.blue[800])),
                  Icon(Icons.phone, color: Colors.blue[800]),
                ],
              ),
            ),
            SizedBox(height: 20),
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
          // Handle navigation based on the selected index
        },
      ),
    );
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cek Saldo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Saldo Anda Saat Ini:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Rp. 1.200.000', style: TextStyle(fontSize: 24, color: Colors.green)),
          ],
        ),
      ),
    );
  }
}

class TransferPage extends StatefulWidget {
  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  String? _selectedMethod;
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transfer')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedMethod,
              items: [
                DropdownMenuItem(value: 'Rekening Sendiri', child: Text('Rekening Sendiri')),
                DropdownMenuItem(value: 'Antarbank', child: Text('Antarbank')),
                DropdownMenuItem(value: 'Virtual Account Billing', child: Text('Virtual Account Billing')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Pilih Metode Transfer',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _accountController,
              decoration: InputDecoration(labelText: 'Nomor Rekening Tujuan', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Jumlah Transfer', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedMethod == null || _accountController.text.isEmpty || _amountController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Harap lengkapi semua data!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Transfer berhasil!')),
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

class DepositoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Deposito')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Pilih Jangka Waktu Deposito:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              items: ['3 Bulan', '6 Bulan', '12 Bulan']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                // Handle selection
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: 'Jumlah Deposito', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add deposito logic here
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

class PembayaranPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pembayaran')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nomor Tagihan', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: 'Jumlah Pembayaran', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add payment logic here
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

class PinjamanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pinjaman')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Jumlah Pinjaman', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: 'Jangka Waktu (bulan)', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add loan logic here
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

class MutasiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mutasi')),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: 5, // Replace with actual transaction count
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Transaksi ${index + 1}'),
              subtitle: Text('Detail transaksi ${index + 1}'),
              trailing: Text('- Rp. 100.000', style: TextStyle(color: Colors.red)),
            ),
          );
        },
      ),
    );
  }
}
