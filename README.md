**Muhammad Raihan Akbar (2206827674)** \
**PBP-B**

# Tugas 9

### Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?
Ya, kita dapat melakukan pengambilan data JSON tanpa membuat model terlebih dahulu. Jika kita hanya mengambil data dari sebuah file JSON atau API dan tidak perlu melakukan manipulasi atau analisis yang kompleks, kita tidak perlu membuat model khusus. Lebih baik atau tidaknya itu tergantung dari kebutuhan kita, jika kita hanya butuh untuk mengambil dan menganalisis data JSON secara sederhana, maka tidak perlu membuat model terlebih dahulu. Namun, jika kita ingin melakukan tugas seperti klasifikasi atau prediksi berdasarkan data JSON, maka kita mungkin perlu membuat model terlebih dahulu. Jika struktur kita kompleks, maka membangun model merupakan keputusan yang lebih baik dikarenakan model membantu kita dalam mengatasi kompleksitas struktur data, dan mengekstrak informasi. <br>

### Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

`CookieRequest` berfungsi untuk mengatur berbagai permintaan HTTP dan pengelola cookie dalam aplikasi Flutter. Dengan instance CookieRequest yang dibagikan melalui `Provider` ke semua komponen, informasi autentikasi dan sesi dapat diakses secara konsisten di seluruh aplikasi. Ini memudahkan setiap widget untuk berinteraksi dengan layanan web, menjadikan manajemen state dan autentikasi lebih efisien. <br>

Pembagian instance CookieRequest secara global memastikan keseragaman dan kemudahan akses ke data sesi tanpa perlu membuat instance baru atau mentransfer informasi secara manual antar komponen. Dengan demikian, penggunaan Provider mempermudah pengelolaan status otentikasi di seluruh aplikasi dan memastikan bahwa setiap bagian dari aplikasi dapat dengan mudah berpartisipasi dalam operasi otentikasi atau interaksi dengan layanan web. <br>

### Jelaskan mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter.
  + Pertama-tama membuat model item. Disini saya mengambil endpoint json dari tugas 6 lalu menggunakan website `quicktype` untuk diubah menjadi model Item. Lalu saya Copy Codenya ke dalam berkas `item.dart` yang berada pada folder `models`.
  + Menambahkan dependensi http dengan run perintah dibawah ini:
  ```
  flutter pub add http
  ```
  + Pada file `android/app/src/main/AndroidManifest.xml` tambahkan kode berikut:
  ```
  ...
    <application>
    ...
    </application>
    <!-- Required to fetch data from the Internet. -->
    <uses-permission android:name="android.permission.INTERNET" />
  ...
  ```
  + Membuat berkas `list_product.dart` pada folder `lib/screens`
  + Pada file `list_item.dart` tambahkan kode berikut:
  ```
  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'dart:convert';
  import 'package:<APP_NAME>/models/product.dart';
  ```
  ```
  class ProductPage extends StatefulWidget {
    const ProductPage({Key? key}) : super(key: key);

    @override
    _ProductPageState createState() => _ProductPageState();
  }

  class _ProductPageState extends State<ProductPage> {
  Future<List<Item>> fetchProduct() async {
      var url = Uri.parse(
          'http://127.0.0.1:8000/main/get-item/');
      var response = await http.get(
          url,
          headers: {"Content-Type": "application/json"},
      );

      // melakukan decode response menjadi bentuk json
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      // melakukan konversi data json menjadi object Product
      List<Item> list_product = [];
      for (var d in data) {
          if (d != null) {
              list_product.add(Item.fromJson(d));
          }
      }
      return list_product;
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text(
                  'List Item',
                ),
              ),
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
          drawer: const LeftDrawer(),
          body: FutureBuilder(
              future: fetchProduct(),
              builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                  } else {
                      if (!snapshot.hasData) {
                      return const Column(
                          children: [
                          Text(
                              "Tidak ada data Item.",
                              style:
                                  TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                          ),
                          SizedBox(height: 8),
                          ],
                      );
                  } else {
                      return ListView.builder(  
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  padding: const EdgeInsets.all(20.0),
                                  child: InkWell(
                                    child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Text(
                                        "${index + 1}. ${snapshot.data![index].fields.name}",
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                        ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text("${snapshot.data![index].fields.amount}"),
                                        const SizedBox(height: 10),
                                        Text("${snapshot.data![index].fields.description}"),
                                        const SizedBox(height: 10),
                                        Text("${snapshot.data![index].fields.rarity}"),
                                          ElevatedButton(
                                            onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DetailItemPage(item: snapshot.data![index]),
                                              ),
                                            );
                                        },
                                        child: const Text('Detail Item'),
                                      ),
                                    ],
                                    ),
                                  )
                              ));
                      }
                  }
              }));
      }
  }
  ```

### Jelaskan mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.

  + Meminta input mengenai username dan password di Flutter.
  + Menggunakan metode http.post untuk mengirim informasi data login user ke server Django
  + Setelah django mendapatkan data informasi login, django akan memverifikasi informasi login. Jika valid, maka django akan mengembalikan token autentikasi.
  + Setelah autentikasi berhasil, tampilan menu atau akses ke fitur tertentu yang memerlukan autentikasi akan di tampilkan di aplikasi flutter.

### Sebutkan seluruh widget yang kamu pakai pada tugas ini dan jelaskan fungsinya masing-masing.
  + `http`: Ditambahkan sebagai dependensi untuk membuat permintaan HTTP
  + `FutureBuilder`: Digunakan untuk membangun widget secara asinkron berdasarkan snapshot terbaru dari data.
  + `Provider` : Digunakan untuk mengelola dan menyediakan state dari kelas `CookieRequest` ke semua widget anak.
  + `Elevated Button`: Untuk membuat button
  + `Text`: Menampilkan teks
  + `SizedBox`: Memberikan space diantara widget
  + `ListView`: Digunakan untuk loop item

### Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).

- [x] Memastikan deployment proyek tugas Django kamu telah berjalan dengan baik. <br>
  + Mencoba redeploy dan bertanya ke kakak asdos jika mengalami kerusakan
- [x] Membuat halaman login pada proyek tugas Flutter. <br>
  + Buat `django-app` bernama authentication
  + Menambahkan `authentication` ke `INSTALLED APPS` pada `settings.py`
  + Menjalankan `pip install django-cors-headers`
  + Menambahkan `corsheaders` ke `INSTALLED APPS` pada `settings.py`
  + Menambahkan `corsheaders.middleware.CorsMiddleware` pada `settings.py`
  + Menambahkan variabel dibawah ini pada `settings.py`:
  ```
  CORS_ALLOW_ALL_ORIGINS = True
  CORS_ALLOW_CREDENTIALS = True
  CSRF_COOKIE_SECURE = True
  SESSION_COOKIE_SECURE = True
  CSRF_COOKIE_SAMESITE = 'None'
  SESSION_COOKIE_SAMESITE = 'None'
  ```
  + Membuat methode view untuk login pada berkas `authentication/views.py`:
  ```
  from django.shortcuts import render
  from django.contrib.auth import authenticate, login as auth_login
  from django.http import JsonResponse
  from django.views.decorators.csrf import csrf_exempt

  @csrf_exempt
  def login(request):
      username = request.POST['username']
      password = request.POST['password']
      user = authenticate(username=username, password=password)
      if user is not None:
          if user.is_active:
              auth_login(request, user)
              # Status login sukses.
              return JsonResponse({
                  "username": user.username,
                  "status": True,
                  "message": "Login sukses!"
                  # Tambahkan data lainnya jika ingin mengirim data ke Flutter.
              }, status=200)
          else:
              return JsonResponse({
                  "status": False,
                  "message": "Login gagal, akun dinonaktifkan."
              }, status=401)

      else:
          return JsonResponse({
              "status": False,
              "message": "Login gagal, periksa kembali email atau kata sandi."
          }, status=401)
  ```
  + Tambahkan kode berikut pada `urlpatterns` di `urls.py` aplikasi authentication:
  ```
  path('login/', login, name='login'),
  ``` 
  + Tambahkan kode berikut pada `urlpatterns` di `urls.py` pada berkas `seven_siege/urls.py`:
  ```
  path('auth/', include('authentication.urls')),
  ```
  + Install beberapa package berikut:
  ```
  flutter pub add provider
  flutter pub add pbp_django_auth
  ```
  + Pada berkas `main.dart` ubahlah kode sebelumnya menjadi seperti ini untuk menyediakan `CookieRequest` library ke semua child widgets dengan menggunakan `provider`:
  ```
    class MyApp extends StatelessWidget {
      const MyApp({Key? key}) : super(key: key);

      @override
      Widget build(BuildContext context) {
          return Provider(
              create: (_) {
                  CookieRequest request = CookieRequest();
                  return request;
              },
              child: MaterialApp(
                  title: 'Flutter App',
                  theme: ThemeData(
                      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
                      useMaterial3: true,
                  ),
                  home: MyHomePage()
              ),
          );
      }
  }
  ```
  + Buat berkas baru dengan nama `login.dart` pada folder `screens`
  + Isilah dengan kode dibawah ini
  ```
  import 'package:shopping_list/screens/menu.dart';
  import 'package:flutter/material.dart';
  import 'package:pbp_django_auth/pbp_django_auth.dart';
  import 'package:provider/provider.dart';

  void main() {
      runApp(const LoginApp());
  }

  class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
          title: 'Login',
          theme: ThemeData(
              primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      );
      }
  }

  class LoginPage extends StatefulWidget {
      const LoginPage({super.key});

      @override
      _LoginPageState createState() => _LoginPageState();
  }

  class _LoginPageState extends State<LoginPage> {
      final TextEditingController _usernameController = TextEditingController();
      final TextEditingController _passwordController = TextEditingController();

      @override
      Widget build(BuildContext context) {
          final request = context.watch<CookieRequest>();
          return Scaffold(
              appBar: AppBar(
                  title: const Text('Login'),
              ),
              body: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          TextField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                  labelText: 'Username',
                              ),
                          ),
                          const SizedBox(height: 12.0),
                          TextField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                  labelText: 'Password',
                              ),
                              obscureText: true,
                          ),
                          const SizedBox(height: 24.0),
                          ElevatedButton(
                              onPressed: () async {
                                  String username = _usernameController.text;
                                  String password = _passwordController.text;

                                  // Cek kredensial
                                  // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                                  // Untuk menyambungkan Android emulator dengan Django pada localhost,
                                  // gunakan URL http://10.0.2.2/
                                  final response = await request.login("http://<APP_URL_KAMU>/auth/login/", {
                                  'username': username,
                                  'password': password,
                                  });
                      
                                  if (request.loggedIn) {
                                      String message = response['message'];
                                      String uname = response['username'];
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => MyHomePage()),
                                      );
                                      ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(
                                              SnackBar(content: Text("$message Selamat datang, $uname.")));
                                      } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                              title: const Text('Login Gagal'),
                                              content:
                                                  Text(response['message']),
                                              actions: [
                                                  TextButton(
                                                      child: const Text('OK'),
                                                      onPressed: () {
                                                          Navigator.pop(context);
                                                      },
                                                  ),
                                              ],
                                          ),
                                      );
                                  }
                              },
                              child: const Text('Login'),
                          ),
                      ],
                  ),
              ),
          );
      }
  }
  ```
  + Pada berkas `main.dart` ubah `home: MyHomePage()` menjadi `home: LoginPage()`
  
- [x] Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter. <br>
  + Pada bagian login diatas sudah disertakan juga cara untuk autentikasi saat login.

- [x] Membuat model kustom sesuai dengan proyek aplikasi Django. <br>
  + Membuka endpoint JSON pada tugas sebelumnya
  + Lalu salin dan copy paste di website `quicktype`
  + Pada situs web Quicktype, ubahlah setup name menjadi Product, source type menjadi JSON, dan language menjadi Dart
  + Tempel data JSON yang telah disalin sebelumnya ke dalam textbox yang tersedia pada Quicktype.
  + Lalu click copy code dan salin pada berkas `models/item.dart`

- [x] Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah kamu deploy. <br>
  - [x] Tampilkan name, amount, dan description dari masing-masing item pada halaman ini. <br>
    + Membuat berkas `list_product.dart` pada folder `lib/screens`
    + Pada file `list_item.dart` tambahkan kode berikut:
    ```
    import 'package:flutter/material.dart';
    import 'package:http/http.dart' as http;
    import 'dart:convert';
    import 'package:<APP_NAME>/models/product.dart';
    ```
    ```
    class ProductPage extends StatefulWidget {
      const ProductPage({Key? key}) : super(key: key);

      @override
      _ProductPageState createState() => _ProductPageState();
    }

    class _ProductPageState extends State<ProductPage> {
    Future<List<Item>> fetchProduct() async {
        var url = Uri.parse(
            'https://muhammad-rafli22-tugas.pbp.cs.ui.ac.id/get-item/');
        var response = await http.get(
            url,
            headers: {"Content-Type": "application/json"},
        );

        // melakukan decode response menjadi bentuk json
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        // melakukan konversi data json menjadi object Product
        List<Item> list_product = [];
        for (var d in data) {
            if (d != null) {
                list_product.add(Item.fromJson(d));
            }
        }
        return list_product;
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
              appBar: AppBar(
                title: const Center(
                  child: Text(
                    'List Item',
                  ),
                ),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            drawer: const LeftDrawer(),
            body: FutureBuilder(
                future: fetchProduct(),
                builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                    } else {
                        if (!snapshot.hasData) {
                        return const Column(
                            children: [
                            Text(
                                "Tidak ada data Item.",
                                style:
                                    TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                            ),
                            SizedBox(height: 8),
                            ],
                        );
                    } else {
                        return ListView.builder(  
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    padding: const EdgeInsets.all(20.0),
                                    child: InkWell(
                                      child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                          Text(
                                          "${index + 1}. ${snapshot.data![index].fields.name}",
                                          style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                          ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text("${snapshot.data![index].fields.amount}"),
                                          const SizedBox(height: 10),
                                          Text("${snapshot.data![index].fields.description}"),
                                          const SizedBox(height: 10),
                                          Text("${snapshot.data![index].fields.rarity}"),
                                            ElevatedButton(
                                              onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => DetailItemPage(item: snapshot.data![index]),
                                                ),
                                              );
                                          },
                                          child: const Text('Detail Item'),
                                        ),
                                      ],
                                      ),
                                    )
                                ));
                        }
                    }
                }));
        }
    }
    ```
- [x] Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar Item. <br>
  - [x] Halaman ini dapat diakses dengan menekan salah satu item pada halaman daftar Item. <br>
    + Pada berkas `list_item.dart` tambahkan kode berikut untuk membuat button ke setiap detail item:
    ```
          ElevatedButton(
        onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailItemPage(item: snapshot.data![index]),
          ),
        );
      },
      child: const Text('Detail Item'),
    ),
    ```
  - [x] Tampilkan seluruh atribut pada model item kamu pada halaman ini. <br>
  - [x] Tambahkan tombol untuk kembali ke halaman daftar item. <br>
  + Untuk menambahkan atribut model dan tombol, buatlah berkas `detail_item.dart` lalu tambahkan kode berikut ini:
  ```
  import 'package:flutter/material.dart';
  import 'package:seven_siege/models/item.dart';
  import 'package:seven_siege/widgets/left_drawer.dart';

  class DetailItemPage extends StatefulWidget {
      final Item item;

      const DetailItemPage({super.key, required this.item});

      @override
      State<DetailItemPage> createState() => _DetailItemPageState();
  }

  class _DetailItemPageState extends State<DetailItemPage> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text(
                  'Detail Item',
                ),
              ),
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
        drawer: const LeftDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Item Name:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.item.fields.name,
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Amount: ${widget.item.fields.amount}',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'Description: ${widget.item.fields.description}',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'Rarity: ${widget.item.fields.rarity}',
                style: const TextStyle(fontSize: 18),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigasi kembali ketika tombol ditekan
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),            
            ],
          ),
        ),
      );
    }
  }
  ```

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