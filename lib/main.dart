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
      width: 60, // Perbesar container sesuai keinginan
      height: 90, // Sesuaikan agar tetap proporsional
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), // Opsional untuk sudut melengkung
        image: DecorationImage(
          image: NetworkImage(
            'https://raw.githubusercontent.com/amaragita/Tugas-Layout-1/main/Foto%204x6.png',
          ),
          fit: BoxFit.contain, // Pastikan gambar tetap proporsional tanpa terpotong
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
                _buildMenuItem(Icons.account_balance_wallet, 'Cek Saldo'),
                _buildMenuItem(Icons.sync_alt, 'Transfer'),
                _buildMenuItem(Icons.savings, 'Deposito'),
                _buildMenuItem(Icons.payment, 'Pembayaran'),
                _buildMenuItem(Icons.business_center, 'Pinjaman'),
                _buildMenuItem(Icons.receipt, 'Mutasi'),
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

  Widget _buildMenuItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 40, color: Colors.blue[800]),
        SizedBox(height: 5),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }
}
