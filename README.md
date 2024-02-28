# Double Jump
Hal pertama yang dilakukan untuk mengimplementasikan double jump adalah membuat sebuah variabel untuk mengetahui apakah double jump dapat dilakukan atau tidak. Pada latihan ini, saya menggunakan sebuah variabel double jump yang bernilai 0 jika double jump belum dilakukan dan 1 jika double jump telah dilakukan.
```
var double_jump = 0
```
Untuk implementasinya, jika player tidak berada di floor (berada di udara) dan double jump belum dilakukan, maka akan melakukan jump dan variabel double_jump diganti unutk menandakan double jump telah dilakukan.

```
# Double Jump
	if !is_on_floor() and Input.is_action_just_pressed('ui_up') :
		if !double_jump:
			double_jump = 1
			velocity.y = jump_speed
```
Pada jump biasa, jika double jump telah dilakukan, maka variabel double_jump akan dikembalikan ke nilai 0 agar double jump dapat dilakukan kembali.
```
if is_on_floor() and Input.is_action_just_pressed('ui_up') and !crouch:
		double_jump = 0
		velocity.y = jump_speed
```
Referensi : https://forum.godotengine.org/t/how-to-double-jump/4562/2

# Crouch
Pada saat crouch, player tidak dapat melompat dan ukuran player termasuk collision area akan juga mengecil dan kecepatan berkurang, seperti banyak game platformer. Sama seperti double jump, akan ada var yang menandakan apakah crouch sedang dilakukan (1) atau tidak (0), serta variabel yang menyimpan kecepatan saat crouch dilakukan
```
var crouch = 0
export (int) var crouch_speed = 200
```
Ketika player menekan tombol down, maka crouch akan aktif. Ketika crouch, speed dari player akan menggunakan value pada variabel crouch_speed. Pada tutorial ini, sprite awal dirotasi agar menghadap horizontal, sehingga scaling diubah pada y untuk mengurangi tinggi dari pesawat.
```
	if is_on_floor() and Input.is_action_just_pressed("ui_down"):
		if crouch:
			crouch = 0
			scale = Vector2 (1,1)
		else:
			crouch = 1
			scale = Vector2 (0.8,1)

# move right		
	if Input.is_action_pressed("ui_right"):
		
		$Sprite.flip_v= false
		if crouch:
			velocity.x += crouch_speed
		elif dash:
			velocity.x += dash_speed
		else:
			velocity.x += speed
			
	
	# move left		
	if Input.is_action_pressed("ui_left"):
		$Sprite.flip_v= true
		if crouch:
			velocity.x -= crouch_speed
		elif dash:
			velocity.x -= dash_speed
		else:
			velocity.x -= speed
```
Referensi (untuk scaling) : https://forum.godotengine.org/t/how-to-scale-a-sprite-through-code/18995

# Dash Sederhana
Untuk dash, saya memilih untuk menggunakan tombol shift untuk mengaktifkan dash untuk mempermudah implementasi. Timer untuk waktu dash juga tidak ditetapkan. Sama seperti kedua contoh di atas, akan ada variabel yang menentukan apakah dash sedang dilakukan (1) atau tidak (0), serta variabel yang menyimpan kecepatan dash.
```
export (int) var dash_speed = 800
var dash = 0
```
Lalu, jika shift ditekan dan dash tidak aktif, maka nilai variabel dash akan berubah menjadi 1. Jika tombol shift dilepas dan dash aktif, nilai variabel dash akan kembali ke 0.
```
	if(Input.is_action_just_pressed("dash")) and !dash:
		dash = 1

	if(Input.is_action_just_released("dash")) and dash:
		dash = 0
```
Lalu jika dash aktif, maka ketika menekan tombol kiri atau kanan, kecepatan player akan sesuai dengan dash_speed.
```
# move right		
	if Input.is_action_pressed("ui_right"):
		
		$Sprite.flip_v= false
		if crouch:
			velocity.x += crouch_speed
		elif dash:
			velocity.x += dash_speed
		else:
			velocity.x += speed
			
	
	# move left		
	if Input.is_action_pressed("ui_left"):
		$Sprite.flip_v= true
		if crouch:
			velocity.x -= crouch_speed
		elif dash:
			velocity.x -= dash_speed
		else:
			velocity.x -= speed
```
Referensi : https://stackoverflow.com/questions/70778208/dash-mechanic-for-2d-platformer-godot-3-4
