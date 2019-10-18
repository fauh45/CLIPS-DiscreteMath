(deftemplate kel
	(slot nama)
	(slot gender)
	(slot lokasi)
	(slot pasangan)
	(multislot ortu (default undefined)))

(deftemplate benci "hate bois"
	(slot nama)
	(multislot benci))

(deftemplate wasiat
	(slot kepada)
	(slot persen))

(deffacts cipali
	(kel(nama Adam)(gender Laki)(lokasi cipali)(ortu Dadang Ji))
	(kel(nama Muntu)(gender Laki)(lokasi cipali)(pasangan Xian)(ortu Dadang Ji))
	(kel(nama Residivis)(gender Perempuan)(lokasi cipali)(ortu Dadang Ji)))

(deffacts cimahi
	(kel(nama Dadang)(gender Laki)(lokasi cimahi)(pasangan Ji)(ortu Peterson Maja))
	(kel(nama Ji)(gender Perempuan)(lokasi cimahi)(pasangan Dadang)(ortu Jang Xin))
	(kel(nama Ganjar)(gender Laki)(lokasi cimahi)(ortu Dadang Ji)))

(deffacts jakarta
	(kel(nama Xian)(gender Perempuan)(lokasi cimahi)(pasangan Muntu)(ortu Jon Xal))
	(kel(nama Jar)(gender Laki)(lokasi cimahi)(ortu Muntu Xian)))

(defrule ortu
	(kel(nama ?nm)(ortu $?ortu))
	=>
	(printout t "Ayah dari " ?nm " : " (nth$ 1 $?ortu) crlf "Ibu dari " ?nm " : " (nth$ 2 $?ortu) crlf)
	(assert (ayah ?nm (nth$ 1 $?ortu)))
	(assert (ibu ?nm (nth$ 2 $?ortu))))

(defrule cucu
	(kel(nama ?nm))
	(kel(nama ?anak)(ortu $? ?nm $?))
	(kel(nama ?cucu)(ortu $? ?anak $?))
	=>
	(printout t "Cucu dari " ?nm " : " ?cucu crlf)
	(assert (cucu ?nm ?cucu)))

(defrule pasangan
	(kel(nama ?nama)(pasangan ?pasangan))
	=>
	(printout t "Pasangan dari " ?nama " : " ?pasangan crlf)
	(assert(pasangan ?nama ?pasangan)))

(defrule kepadaortu
	(ayah Muntu ?ayah)
	(ibu Muntu ?ibu)
	=>
	(assert(wasiat(kepada ?ayah)(persen 30)))
	(assert(wasiat(kepada ?ibu)(persen 20))))

(defrule kepadaanak
	(ayah ?anak Muntu)
	=>
	(assert(wasiat(kepada ?anak)(persen 20))))

(defrule kepadapasangan
	(pasangan Muntu ?pasangan)
	=>
	(assert(wasiat(kepada ?pasangan)(persen 30))))

(defrule reflexive
	(kel(nama ?nama))
	=>
	(assert(tidaklebihkaya ?nama ?nama)))

;Muntu membenci semua kecuali Residivis

(defrule muntu
	(kel(nama ?name &~Residivis)(lokasi cipali))
	=>
	(assert(benci(nama Muntu)(benci ?name))))

;Adam tidak membenci satupun yang muntu benci, soal belum jelas

(defrule adam
	(kel(lokasi cipali))
	=>
	(assert(benci(nama Adam)(benci null))))

;Residivisi membenci semua yang Muntu benci dan semua yang tidak lebih kaya dari Muntu

(defrule residivis
	(benci(nama Muntu)(benci ?nama))
	(tidaklebihkaya Muntu ?nama)
	=>
	(assert(benci(nama Residivis)(benci ?nama))))

;Pembunuh tinggal di Cipali, pembunuh selalu membenci yang dibunuhnya, tidak lebih kaya dari yang di bunuhnya

(defrule cari
	(kel(nama ?nama)(lokasi cipali))
	(benci(nama ?nama)(benci $? Muntu $?))
	(tidaklebihkaya Muntu ?nama1)
	(test (eq ?nama ?nama1))
	=>
	(assert (killer ?nama))
	(printout t "Nama Pembunuh : " ?nama crlf))

(defrule wasiat
	(wasiat(kepada ?kpd)(persen ?persen))
	=>
	(printout t ?kpd " dapat " ?persen "%" crlf))
