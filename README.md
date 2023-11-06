**Muhammad Raihan Akbar (2206827674)** \
**PBP-B**

# Tugas 7

### 1. Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?

1. **Stateless Widget**
    - Tidak memiliki keadaan (state), tidak berubah secara otomatis melalui tindakan atau perilaku internal
    - Perubahan pada *widget* tersebut dipicu oleh peristiwa eksternal pada *parent widget* dalam *tree widget*.
    - Hanya memiliki properti final yang ditentukan selama konstruksi, dan itulah satu-satunya yang perlu dibangun di layar perangkat.

    Contoh:
    ```dart
    class MyTextWidget extends StatelessWidget {
    final String text;
    
    MyTextWidget(this.text);
    
    @override
    Widget build(BuildContext context) {
        return Text(text);
    }
    }
    ```

2. **Stateful Widget**
    - Deskripsi bisa dirubah secara dinamis.
    - Tidak dapat diubah, namun memiliki kelas *State* terkait yang mewakili keadaan (state) saat ini dari *widget* tersebut.

    Contoh:
    ```dart
    class CounterWidget extends StatefulWidget {
    @override
    _CounterWidgetState createState() => _CounterWidgetState();
    }

    class _CounterWidgetState extends State<CounterWidget> {
    int _counter = 0;

    void incrementCounter() {
        setState(() {
        _counter++;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Column(
        children: <Widget>[
            Text('Counter: $_counter'),
            ElevatedButton(
            onPressed: incrementCounter,
            child: Text('Increment'),
            ),
        ],
        );
    }
    }
    ```

### 2. Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.
- MaterialApp adalah Widget root dari aplikasi Flutter. Biasanya digunakan untuk mengatur tema dan navigasi.
- ThemeData adalah widget yang digunakan untuk mengatur tema aplikasi.
- ColorScheme adalah widget yang digunakan untuk mendefinisikan skema warna yang akan digunakan oleh tema.
- Scaffold adalah kerangka dasar visual Material Design untuk aplikasi Flutter. Biasanya digunakan untuk menyediakan struktur dasar aplikasi, seperti AppBar, Drawer, dan BottomNavigationBar.
- AppBar adalah bar di bagian atas Scaffold yang biasanya berisi judul aplikasi.
- Text adalah widget yang digunakan untuk menampilkan teks dengan berbagai gaya dan format.
- Padding adalah widget yang digunakan untuk memberikan padding ke widget lain.
- Column adalah widget yang digunakan untuk menampilkan sejumlah widget childern dalam urutan vertikal.
- GridView.count adalah widget yang digunakan untuk menampilkan grid item dengan jumlah kolom yang ditentukan.
- Material adalag widget yang digunakan untuk memberikan efek visual Material Design ke widget lain.
- InkWell adalah widget yang digunakan untuk memberikan efek visual Material Design dan juga dapat menangani gestur tap.
- Container adalah widget yang digunakan untuk menggabungkan beberapa widget dalam satu kotak dan juga dapat memberikan padding, margin, dan dekorasi.
- Center adalah widget yang digunakan untuk memusatkan widget anaknya.
- Icon adalah widget yang digunakan untuk menampilkan ikon dengan berbagai gaya dan ukuran.
- SnackBar adalah widget yang digunakan untuk menampilkan pesan ringkas di bagian bawah layar.

### 3. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step (bukan hanya sekadar mengikuti tutorial)

1. *Generate* proyek Flutter baru dengan nama `seven_siege` dengan menjalankan kode berikut.
    ```
    flutter create seven_siege
    cd seven_siege
    ```

2. Membuat file `menu.dart` pada `seven_siege/lib` dan menambahkan import material flutter.
    ```dart
    import 'package:flutter/material.dart';
    ```

3. Membuat class ShopItem dengan atribut yang sesuai
    ```dart
    class ShopItem {
        final String name;
        final IconData icon;
        final Color color;

        ShopItem(this.name, this.icon, this.color);
    }
    ```

4. Meng-*cut* line ke-39 sampai line akhir pada `main.dart` ke `menu.dart` serta mengganti properti `home` sebagai berikut.
    ```dart
    home: MyHomePage(),
    ```

5. Mengubah MyHomePage pada `menu.dart` sebagai statelessWidget sebagai berikut.
    ```dart
    class MyHomePage extends StatelessWidget {
        MyHomePage({Key? key}) : super(key: key);
    }
    ```

6. Menambahkan variable list yang menampung object item pada class MyHomePage sebagai berikut.
    ```dart
    ...
    final List<ShopItem> items = [
        ShopItem("Lihat Item", Icons.checklist, Colors.yellow),
        ShopItem("Tambah Item", Icons.add_shopping_cart, Colors.green),
        ShopItem("Logout", Icons.logout, Colors.blue),
    ];
    ```

7. Menambahkan widget build yang melakukan return `Scaffold`
    ```dart
    @override
    Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
            title: const Text(
                'Seven Siege',
            ),
            ),
            body: SingleChildScrollView(
            // Widget wrapper yang dapat discroll
            child: Padding(
                padding: const EdgeInsets.all(10.0), // Set padding dari halaman
                child: Column(
                // Widget untuk menampilkan children secara vertikal
                children: <Widget>[
                    const Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                    child: Text(
                        'Seven Siege Cards', // Text yang menandakan toko
                        textAlign: TextAlign.center,
                        style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ),
                    // Grid layout
                    GridView.count(
                    // Container pada card kita.
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    children: items.map((ShopItem item) {
                        // Iterasi untuk setiap item
                        return ShopCard(item);
                    }).toList(),
                    ),
                ],
                ),
            ),
            ),
        );
    }
    ```

8. Menambahkan class ShopCard sebagai stateless widget untuk menampilkan card sebagai berikut.
    ```dart
    class ShopCard extends StatelessWidget {
    final ShopItem item;

    const ShopCard(this.item, {super.key}); // Constructor

    @override
    Widget build(BuildContext context) {
        return Material(
        color: item.color,
        child: InkWell(
            // Area responsive terhadap sentuhan
            onTap: () {
            // Memunculkan SnackBar ketika diklik
            ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content: Text("Kamu telah menekan tombol ${item.name}!")));
            },
            child: Container(
            // Container untuk menyimpan Icon dan Text
            padding: const EdgeInsets.all(8),
            child: Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Icon(
                    item.icon,
                    color: Colors.white,
                    size: 30.0,
                    ),
                    const Padding(padding: EdgeInsets.all(3)),
                    Text(
                    item.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    ),
                ],
                ),
            ),
            ),
        ),
        );
    }
    }
    ```