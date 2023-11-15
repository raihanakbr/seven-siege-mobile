**Muhammad Raihan Akbar (2206827674)** \
**PBP-B**

# Tugas 8

### 1. Jelaskan perbedaan antara ```Navigator.push()``` dan ```Navigator.pushReplacement()```, disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!

- **Navigator.push()** : Menambahkan suatu route ke dalam stack route yang dikelola oleh Navigator. Method ini menyebabkan route yang ditambahkan berada pada paling atas stack, sehingga route yang baru saja ditambahkan tersebut akan muncul dan ditampilkan kepada pengguna
    ```dart
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HalamanKedua()),
    );

- **Navigator.pushReplacement()** : Menghapus route yang sedang ditampilkan kepada pengguna dan menggantinya dengan suatu route. Method ini menyebabkan aplikasi untuk berpindah dari route yang sedang ditampilkan kepada pengguna ke suatu route yang diberikan. Pada stack route yang dikelola Navigator, route lama pada atas stack akan digantikan secara langsung oleh route baru yang diberikan tanpa mengubah kondisi elemen stack yang berada di bawahnya.
    ```dart
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HalamanKedua()),
    );

    ```

### 2. Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya masing-masing!

- **Container**: Kita dapat menambahkan padding, margin, border, dan warna latar belakang seperti properti dalam widget ini dan kita dapat menyesuaikannya sesuai kebutuhan kita1.
- **Row dan Column**: Widget ini digunakan untuk menata sejumlah widget anak secara horizontal (Row) atau vertikal (Column). Anda dapat menentukan bagaimana widget anak harus ditempatkan dan berapa banyak ruang yang harus mereka tempati2.
- **ListView**: Untuk menampilkan anak-anaknya satu demi satu dalam arah scroll.
- **Padding**: Digunakan untuk memberikan jarak antara widget dan widget lainnya di sekelilingnya2.
- **Align**: Digunakan untuk menyelaraskan widget anaknya dalam dirinya sendiri dan secara opsional mengatur ukurannya berdasarkan ukuran anaknya2.
- **Center**: Digunakan untuk memusatkan widget anaknya dalam dirinya sendiri-sendiri.

### 3. Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!

- **Nama Item**: Elemen input ini menggunakan widget TextFormField dengan validator yang memeriksa apakah nilai input kosong atau tidak. Elemen ini digunakan untuk memasukkan nama item yang akan ditambahkan ke daftar belanja.
- **Jumlah**: Elemen input ini juga menggunakan widget TextFormField. Validatornya memeriksa apakah nilai input kosong dan apakah nilai tersebut berupa angka. Elemen ini digunakan untuk memasukkan jumlah item yang akan dibeli.
- **Harga**: Sama seperti elemen input “Jumlah”, elemen input “Harga” juga menggunakan widget TextFormField dengan validator yang sama. Elemen ini digunakan untuk memasukkan harga per item.
- **Deskripsi**: Elemen input ini menggunakan widget TextFormField dengan validator yang memeriksa apakah nilai input kosong atau tidak. Elemen ini digunakan untuk memasukkan deskripsi item.

### 4. Bagaimana penerapan clean architecture pada aplikasi Flutter?

Clean Architecture adalah prinsip desain perangkat lunak yang mempromosikan pemisahan tanggung jawab dan bertujuan untuk menciptakan basis kode yang modular, dapat diskalakan, dan dapat diuji1. Berikut adalah cara penerapannya dalam Flutter:

- **Layer Domain**: Layer ini berfungsi sebagai inti dari aplikasi yang berisi logika bisnis dan model data2.
- **Layer Aplikasi**: Layer ini mengimplementasikan use case dari aplikasi dan menjembatani layer infrastruktur dan presentasi2.
- **Layer Infrastruktur**: Layer ini berurusan dengan interaksi dengan dunia luar termasuk database, server web, antarmuka pengguna2.
- **Layer Presentasi**: Layer ini berisi kode yang merender antarmuka pengguna di mana permintaan dibuat dan respons dikembalikan2.
- **Penerapan Prinsip-Prinsip**: Prinsip-prinsip seperti Single Responsibility Principle dan Dependency Injection diterapkan untuk memastikan setiap bagian sistem memenuhi peran yang bermakna dan intuitif sambil memaksimalkan kemampuannya untuk beradaptasi dengan perubahan3.
- **Aturan Ketergantungan**: Kode sumber hanya bergantung ke dalam. Ini berarti modul ke dalam tidak sadar atau bergantung pada modul luar. Namun, modul luar sadar dan bergantung pada modul dalam3.
- **Pembagian Layer**: Membagi setiap layer menjadi sub-layer dan menetapkan hierarki ketergantungan yang jelas adalah aspek penting dalam membangun aplikasi yang kuat

### 5. Implementasi Checklist

- Membuat ```itemlist_form.dart``` pada folder ```lib```
- Menambahkan empat elemen input, yaitu name, amount, price dan description
    ```dart
    String _name = "";
    int _price = 0;
    int _amount = 0;
    String _description = "";
    ```
- Menambahkan tombol *save* sebagai berikut
    ```dart
                Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                        if (_formKey.currentState!.validate()) {
                        items.add(Item(
                            name: _name,
                            amount: _amount,
                            price: _price,
                            description: _description,
                        ));
                        showDialog(
                            context: context,
                            builder: (context) {
                            return AlertDialog(
                                title: const Text('Card berhasil tersimpan'),
                                content: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Text('Nama: $_name'),
                                    Text('Jumlah: $_amount'),
                                    Text('Harga: $_price'),
                                    Text('Deskripsi: $_description'),
                                    ],
                                ),
                                ),
                                actions: [
                                TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                    Navigator.pop(context);
                                    },
                                ),
                                ],
                            );
                            },
                        );
                        }
                        _formKey.currentState!.reset();
                    },
                    child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                    ),
                    ),
                ),
                ),
    ```
- Menambahkan validasi input sebagai berikut
    ```dart
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                    hintText: "Nama Card",
                    labelText: "Nama Card",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                    ),
                    ),
                    onChanged: (String? value) {
                    setState(() {
                        _name = value!;
                    });
                    },
                    validator: (String? value) {
                    if (value == null || value.isEmpty) {
                        return "Nama tidak boleh kosong!";
                    }
                    return null;
                    },
                ),
                ),
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                    hintText: "Jumlah",
                    labelText: "Jumlah",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                    ),
                    ),
                    onChanged: (String? value) {
                    setState(() {
                        _amount = int.parse(value!);
                    });
                    },
                    validator: (String? value) {
                    if (value == null || value.isEmpty) {
                        return "Jumlah tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                        return "Jumlah harus berupa angka!";
                    }
                    return null;
                    },
                ),
                ),
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                    hintText: "Harga",
                    labelText: "Harga",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                    ),
                    ),
                    onChanged: (String? value) {
                    setState(() {
                        _price = int.parse(value!);
                    });
                    },
                    validator: (String? value) {
                    if (value == null || value.isEmpty) {
                        return "Harga tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                        return "Harga harus berupa angka!";
                    }
                    return null;
                    },
                ),
                ),
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                    hintText: "Deskripsi",
                    labelText: "Deskripsi",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                    ),
                    ),
                    onChanged: (String? value) {
                    setState(() {
                        _description = value!;
                    });
                    },
                    validator: (String? value) {
                    if (value == null || value.isEmpty) {
                        return "Deskripsi tidak boleh kosong!";
                    }
                    return null;
                    },
                ),
                ),
    ```
- Mengarahkan pengguna ke halaman form tambah *item* baru ketika menekan tombol 'Tambah Card' pada halaman utama
    ```dart
    if (item.name == "Tambah Card") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ItemFormPage()));
    }
    ```
- Memunculkan data sesuai isi dari formulir yang diisi dalam sebuah *pop-up* setelah menekan tombol *Save* pada halaman formulir `Tambah Card` baru
    ```dart
                    onPressed: () {
                        if (_formKey.currentState!.validate()) {
                        items.add(Item(
                            name: _name,
                            amount: _amount,
                            price: _price,
                            description: _description,
                        ));
                        showDialog(
                            context: context,
                            builder: (context) {
                            return AlertDialog(
                                title: const Text('Card berhasil tersimpan'),
                                content: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Text('Nama: $_name'),
                                    Text('Jumlah: $_amount'),
                                    Text('Harga: $_price'),
                                    Text('Deskripsi: $_description'),
                                    ],
                                ),
                                ),
                                actions: [
                                TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                    Navigator.pop(context);
                                    },
                                ),
                                ],
                            );
                            },
                        );
                        }
                        _formKey.currentState!.reset();
                    },
    ```
- Membuat file `left_drawer.dart` pada folder widgets serta menambahkan tombol untuk *routing* ke halaman utama dan tambah *card* sebagai berikut
    ```dart
            ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Halaman Utama'),
                // Bagian redirection ke MyHomePage
                onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                    ));
                },
            ),
            ListTile(
                leading: const Icon(Icons.add_shopping_cart),
                title: const Text('Tambah Card'),
                // Bagian redirection ke ShopFormPage
                onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ItemFormPage(),
                    ));
                },
            ),
    ```

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

### 3. Implementasi Checklist

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