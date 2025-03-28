# Proses Pengerjaan

## Latihan: Basic 3D Plane Movement
Saya membuat scene baru untuk menampung objek player yang berbentuk kapsul dengan tipe node CharacterBody3D serta menambahkan
node-node children, seperti CollisionShape3D dan MeshInstance3D. CollisionShape3D dan MeshInstance3D juga dibuat dengan tipe bentuk kapsul.
Ditambahkan juga node bernama head yang memiliki children berupa Camera3D. Posisi head diletakkan di atas body sehingga player dapat melihat 
melalui posisi First-Person.

Kemudian, saya menambahkan script pada player yang berguna untuk menggerakkan player serta memutar kamera.

## Latihan: Object Interaction
Saya menambahkan script baru yang berguna untuk melakukan interaksi dengan object menggunakan tombol E. Script ini melakukan ekstensi terhadap
class Interactable yang memiliki fungsi interact sehingga kita dapat melakukan override terhadap interact tersebut.

Script ini ditempelkan pada StaticBody di bagian Switch sehingga menyebabkan switch dapat diinteraksi. Kemudian saya menambahkan RayCast3D pada
bagian kamera player dengan panjang z = -10 m sehingga dapat melakukan interaksi dengan switch.

## Latihan: Membuat Level 3D Menggunakan CSG
Saya menambahkan ruangan dengan menggunakan CSGBox3D kemudian menambahkan furnitur lampu dengan melakukan kombinasi union terhadap CSGCylinder3D dan 
CSGPolygon3D. Kombinasi dilakukan dengan parent node CSGCombiner3D. Kemudian saya juga membuat beberapa CSGBox3D kembali untuk membuat ruangan tambahan,
lubang, area menang atau kalah, serta kotak untuk melompat. 

## Latihan Mandiri: Eksplorasi Mechanics 3D
Saya mengimplementasi sistem sprinting dengan menambahkan variabel curSpeed yang berguna untuk penggantian speed biasa dan speed ketika sprint. Sprint dilakukan
dengan menahan tombol Shift. Tombol ini di-register pada bagian Input Map.

Saya mengimplementasi sistem crouch dengan melakukan register tombol Ctrl pada bagian input map. Pada bagian script ditambahkan variabel-variabel untuk mengatur kecepatan
kapsul, mengatur tinggi mesh, mengatur tinggi head, dan lain-lain. Crouch dilakukan dengan cara toggle pada tombol Ctrl.