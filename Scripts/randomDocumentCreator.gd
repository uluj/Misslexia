extends Node

# Havuzlar
var id_names = ["Hamza Ozcan", "Nadir Turktur", "Beyzanur Kahraman", "Uluc Gungor", "Mert Celik", "Azar Gul", "Selin Suvar", "Busra Ozdemirci", "Muhammed Can", "Cem Ucar"]
var id_numbers = ["A123", "B456", "C789", "D012"]
var document_illness = ["Herhangi bir hastaligi yok", "Radyasyon yanigi var.", "Herhangi bir hastaligi yok", "Uyusturucu Bagamlisi", "Enfekte", "Herhangi bir hastaligi yok"]

# Hastalık sınıflandırmaları
var dogru_document_illness = ["Herhangi bir hastaligi yok", "Radyasyon yanigi var.", "Herhangi bir hastaligi yok"]
var hatali_document_illness = ["Uyusturucu Bagamlisi", "Enfekte"]

# Metin alanlarına referans
@onready var id_name_label = $idName
@onready var id_number_label = $idNumber
@onready var document_name_label = $documentName
@onready var document_number_label = $documentNumber
@onready var document_illness_label = $documentIllness
@onready var MainScene = $".."
@onready var reset_timer = $ResetTimer

func _ready():
	randomize() # Rastgele sayılar için başlatıcı
	_start_reset_timer()
	await get_tree().create_timer(4).timeout

func _start_reset_timer():
	var timer = Timer.new()
	timer.wait_time = 4
	timer.one_shot = true
	add_child(timer)
	await get_tree().create_timer(4).timeout
	timer.start()

# Düğme tıklama fonksiyonu
func _on_create_new_documents_pressed():
	# Havuzdan rastgele seç
	var random_id_name = id_names[randi() % id_names.size()]
	var random_document_name = random_id_name
	var random_id_number = id_numbers[randi() % id_numbers.size()]
	var random_document_number = random_id_number
	var random_document_illness = document_illness[randi() % document_illness.size()]

	var is_hatalı = false # Hata durumu

	# Hata ihtimali %30
	if randi() % 100 < 20:
		# Hata oluştur: isim veya numara uyumsuzluğu
		var random_mismatch = randi() % 2
		if random_mismatch == 0:
			# İsim uyumsuzluğu
			random_document_name = id_names[randi() % id_names.size()]
		else:
			# Numara uyumsuzluğu
			random_document_number = id_numbers[randi() % id_numbers.size()]
		is_hatalı = true

	# Hastalığın durumunu kontrol et
	if random_document_illness in hatali_document_illness:
		is_hatalı = true

	# Etiketleri güncelle
	id_name_label.text = random_id_name
	document_name_label.text = random_document_name
	id_number_label.text = random_id_number
	document_number_label.text = random_document_number
	document_illness_label.text = random_document_illness

	# Hata durumu çıktısı
	if is_hatalı:
		MainScene.currentDocument = false
		MainScene.is_there_any_document = true
		print("Hatali belge oluşturuldu.")
	else:
		MainScene.currentDocument = true
		MainScene.is_there_any_document = true
		print("Dogru belge oluşturuldu.")

	# Timer başlat
	reset_timer.start(4)

# Etiketleri sıfırlama fonksiyonu
func _reset_labels():
	id_name_label.text = "[Boş]"
	document_name_label.text = "[Boş]"
	id_number_label.text = "[Boş]"
	document_number_label.text = "[Boş]"
	document_illness_label.text = "[Boş]"
