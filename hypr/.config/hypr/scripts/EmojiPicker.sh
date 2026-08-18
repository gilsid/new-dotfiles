#!/usr/bin/env bash
# ==================================================
#  Emoji Picker — rofi grid (5 kolom) + wl-copy
#  Cari emoji pakai nama EN atau Indonesia
# ==================================================

rofi_theme="$HOME/.config/rofi/config-emoji.rasi"

list='
😀	Grinning Face · Wajah Tersenyum Lebar
😁	Beaming Face · Senyum Gigi
😂	Tears of Joy · Tertawa Sampai Nangis
🤣	Rolling Laughing · Ngakak
😊	Smiling Eyes · Senyum Sopan
😍	Heart-Eyes · Mata Hati
🥰	Smiling Hearts · Wajah Berhati
😘	Blowing Kiss · Kirim Ciuman
😉	Winking · Kedip
🤔	Thinking · Berpikir
🤨	Raised Eyebrow · Mengerut Alis
😅	Sweat Smile · Senyum Keringat
🥹	Holding Back Tears · Tahan Nangis
😭	Loudly Crying · Nangis Keras
😢	Crying · Sedih
😴	Sleeping · Ngantuk
🤤	Drooling · Ngiler
😡	Angry · Marah
🤬	Angry Symbols · Kesal Makian
🤯	Exploding Head · Meledak Kaget
😱	Screaming Fear · Jerit Takut
😨	Fearful · Ketakutan
😷	Medical Mask · Masker
🤒	Thermometer · Demam Sakit
🥵	Hot Face · Kepanasan
🥶	Cold Face · Kedinginan
😵	Crossed Eyes · Pusing
🤮	Vomiting · Muntah
🥳	Partying · Pesta
😇	Halo · Malaikat
😈	Horns Smile · Setan Tersenyum
🤠	Cowboy Hat · Koboi
🤡	Clown · Badut
👻	Ghost · Hantu
💀	Skull · Tengkorak
👽	Alien · Alien
🤖	Robot · Robot
🫡	Saluting · Hormat Salam
🫠	Melting Face · Wajah Meleleh
🥲	Smile Tear · Senyum Nangis
👋	Waving Hand · Lambai Tangan
🤚	Raised Back Hand · Belakang Tangan
✋	Raised Hand · Tangan Terangkat
🖐️	Splayed Fingers · Lima Jari
👌	OK Hand · Oke
🤏	Pinching · Cubit
🤞	Crossed Fingers · Semoga Beruntung
🤟	Love You Gesture · Aku Sayang Kamu
🤘	Horns Metal · Tanduk Metal
👍	Thumbs Up · Jempol Naik
👎	Thumbs Down · Jempol Turun
👊	Fist · Tinju
✊	Raised Fist · Tinju Terangkat
👏	Clapping · Tepuk Tangan
🙌	Raising Hands · Tangan Terbuka
🙏	Folded Hands · Berdoa Terima Kasih
💪	Flexed Biceps · Otot Kuat
🫶	Heart Hands · Tangan Hati
🤝	Handshake · Jabat Tangan
✌️	Victory · Damai
🤙	Call Me · Telepon Aku
💅	Nail Polish · Poles Kuku
👀	Eyes · Mata
👉	Point Right · Tunjuk Kanan
👆	Point Up · Tunjuk Atas
✍️	Writing Hand · Menulis
❤️	Red Heart · Hati Merah
🧡	Orange Heart · Hati Oranye
💛	Yellow Heart · Hati Kuning
💚	Green Heart · Hati Hijau
💙	Blue Heart · Hati Biru
💜	Purple Heart · Hati Ungu
🖤	Black Heart · Hati Hitam
🤍	White Heart · Hati Putih
💔	Broken Heart · Hati Patah
💕	Two Hearts · Dua Hati
💖	Sparkling Heart · Hati Berkilau
💗	Growing Heart · Hati Tumbuh
💓	Beating Heart · Hati Berdetak
💘	Heart Arrow · Panah Asmara
💝	Heart Ribbon · Hati Pita
💞	Revolving Hearts · Hati Berputar
❤️‍🔥	Heart on Fire · Hati Terbakar
💯	Hundred Points · Seratus
⭐	Star · Bintang
✨	Sparkles · Kilau
🔥	Fire · Api
💥	Collision · Tabrakan
🌟	Glowing Star · Bintang Bersinar
🌈	Rainbow · Pelangi
⚡	High Voltage · Petir
🐶	Dog Face · Wajah Anjing
🐱	Cat Face · Wajah Kucing
🐭	Mouse Face · Wajah Tikus
🐹	Hamster · Hamster
🐰	Rabbit Face · Wajah Kelinci
🦊	Fox · Rubah
🐻	Bear · Beruang
🐼	Panda · Panda
🐨	Koala · Koala
🐯	Tiger Face · Wajah Harimau
🦁	Lion · Singa
🐮	Cow Face · Wajah Sapi
🐷	Pig Face · Wajah Babi
🐸	Frog · Katak
🐵	Monkey Face · Wajah Monyet
🦄	Unicorn · Unicorn
🐧	Penguin · Penguin
🐦	Bird · Burung
🐤	Baby Chick · Anak Ayam
🦅	Eagle · Elang
🦉	Owl · Burung Hantu
🐍	Snake · Ular
🐢	Turtle · Kura-kura
🐙	Octopus · Gurita
🐝	Honeybee · Lebah
🦋	Butterfly · Kupu-kupu
🐬	Dolphin · Lumba-lumba
🐳	Spouting Whale · Paus
🦈	Shark · Hiu
🐊	Crocodile · Buaya
🍎	Red Apple · Apel
🍌	Banana · Pisang
🍉	Watermelon · Semangka
🍇	Grapes · Anggur
🍓	Strawberry · Stroberi
🍑	Peach · Persik
🍊	Tangerine · Jeruk
🍋	Lemon · Lemon
🥑	Avocado · Alpukat
🍕	Pizza · Pizza
🍔	Hamburger · Burger
🍟	French Fries · Kentang Goreng
🌭	Hot Dog · Sosis Bakar
🍿	Popcorn · Popcorn
🍣	Sushi · Sushi
🍜	Steaming Bowl · Mie Kuah
🍝	Spaghetti · Spaghetti
🍦	Soft Ice Cream · Es Krim
🍩	Doughnut · Donat
🍪	Cookie · Biskuit
🎂	Birthday Cake · Kue Ulang Tahun
🍰	Shortcake · Kue Tart
☕	Hot Beverage · Kopi
🍵	Teacup · Teh
🧋	Bubble Tea · Boba
🍺	Beer Mug · Bir
🍷	Wine Glass · Anggur Merah
🥤	Cup Straw · Es Gelas
☀️	Sun · Matahari
🌤️	Sun Small Cloud · Cerah Berawan
☁️	Cloud · Awan
🌧️	Cloud Rain · Hujan
🌨️	Cloud Snow · Salju
🌪️	Tornado · Angin Puting Beliung
🌊	Water Wave · Ombak
🍀	Four Leaf Clover · Semanggi
🌹	Rose · Mawar
🌸	Cherry Blossom · Bunga Sakura
🌻	Sunflower · Bunga Matahari
🌴	Palm Tree · Pohon Palem
🌵	Cactus · Kaktus
🍄	Mushroom · Jamur
💻	Laptop · Laptop
📱	Mobile Phone · HP
⌨️	Keyboard · Papan Ketik
🖥️	Desktop Computer · Komputer
🎧	Headphone · Headphone
🎮	Video Game · Game
🕹️	Joystick · Stik Game
🎲	Die · Dadu
🎯	Bullseye · Target
🏀	Basketball · Basket
⚽	Soccer Ball · Sepak Bola
🏆	Trophy · Piala
🥇	Gold Medal · Medali Emas
💎	Gem Stone · Berlian
👑	Crown · Mahkota
💍	Ring · Cincin
🎁	Wrapped Gift · Kado
🎉	Party Popper · Pesta Konfeti
🎈	Balloon · Balon
📚	Books · Buku
📖	Open Book · Buku Terbuka
✏️	Pencil · Pensil
📝	Memo · Catatan
🔑	Key · Kunci
🔒	Locked · Terkunci
🔓	Unlocked · Terbuka
📷	Camera · Kamera
🎬	Clapper Board · Film
🎵	Musical Note · Not Musik
🎶	Musical Notes · Nada
🎤	Microphone · Mikrofon
🎸	Guitar · Gitar
🎹	Piano Keyboard · Piano
🥁	Drum · Drum
💡	Light Bulb · Lampu
🔦	Flashlight · Senter
💰	Money Bag · Uang
💵	Dollar Banknote · Uang Dolar
💳	Credit Card · Kartu Kredit
🛒	Shopping Cart · Keranjang Belanja
✈️	Airplane · Pesawat
🚗	Automobile · Mobil
🚕	Taxi · Taksi
🚀	Rocket · Roket
🛸	Flying Saucer · UFO
🚲	Bicycle · Sepeda
🏠	House · Rumah
🏡	House Garden · Rumah Berkebun
🏢	Office Building · Gedung Kantor
🏥	Hospital · Rumah Sakit
🏫	School · Sekolah
🕌	Mosque · Masjid
⛪	Church · Gereja
🛕	Hindu Temple · Pura
🌍	Globe · Dunia
🇮🇩	Indonesia Flag · Bendera Indonesia
✅	Check Mark · Centang
❌	Cross Mark · Silang
⚠️	Warning · Peringatan
🚫	Prohibited · Dilarang
❗	Exclamation Mark · Seru Merah
❓	Question Mark · Tanya Merah
♻️	Recycling · Daur Ulang
⏰	Alarm Clock · Jam Alarm
📅	Calendar · Kalender
📌	Pushpin · Pin
🔔	Bell · Lonceng
🚨	Police Light · Lampu Polisi
💤	ZZZ · Tidur
💬	Speech Balloon · Gelembung Bicara
💭	Thought Balloon · Gelembung Pikir
🪩	Mirror Ball · Bola Disko
'

picked=$(echo "$list" | rofi -dmenu -i \
    -display-columns 1 \
    -display-column-separator '\t' \
    -config "$rofi_theme" -p "Emoji")

[ -z "$picked" ] && exit 1

emoji="${picked%%$'\t'*}"
echo -n "$emoji" | wl-copy
