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
	(slot sebagai)
	(slot persen))

(deffacts cipali
	(kel(nama Adam)(gender Laki)(lokasi cipali)(ortu Dadang Ji))
	(kel(nama Muntu)(gender Laki)(lokasi cipali)(pasangan Xian)(ortu Dadang Ji))
	(kel(nama Residivis)(gender Perempuan)(lokasi cipali)(pasangan Gorty)(ortu Dadang Ji)))

(deffacts cimahi
	(kel(nama Dadang)(gender Laki)(lokasi cimahi)(pasangan Ji))
	(kel(nama Ji)(gender Perempuan)(lokasi cimahi)(pasangan Dadang))
	(kel(nama Ganjar)(gender Laki)(lokasi cimahi)(ortu Dadang Ji)))

(deffacts jakarta
	(kel(nama Xian)(gender Perempuan)(lokasi jakarta)(pasangan Muntu))
	(kel(nama Jar)(gender Laki)(lokasi jakarta)(pasangan Maja)(ortu Muntu Xian))
	(kel(nama Maja)(gender Perempuan)(lokasi jakarta)(pasangan Jar))
	(kel(nama Peterson)(gender Laki)(lokasi jakarta)(ortu Jar Maja)))

(deffacts bandung
	(kel(nama Gorty)(gender Perempuan)(lokasi bandung)(pasangan Residivis))
	(kel(nama Res)(gender Perempuan)(lokasi bandung)(ortu Residivis Gorty)))

(defrule input
	=>
	(printout t "Siapakah yang terbunuh : " crlf)
	(assert (nama (read))))

(defrule ortu
	(kel(nama ?nm)(ortu $?ortu))
	=>
	;(printout t "Ayah dari " ?nm " : " (nth$ 1 $?ortu) crlf "Ibu dari " ?nm " : " (nth$ 2 $?ortu) crlf)
	(assert (ayah ?nm (nth$ 1 $?ortu)))
	(assert (ibu ?nm (nth$ 2 $?ortu))))

(defrule cucu
	(kel(nama ?nm))
	(kel(nama ?anak)(ortu $? ?nm $?))
	(kel(nama ?cucu)(ortu $? ?anak $?))
	=>
	;(printout t "Cucu dari " ?nm " : " ?cucu crlf)
	(assert (cucu ?nm ?cucu)))

(defrule pasangan
	(kel(nama ?nama)(pasangan ?pasangan))
	=>
	;(printout t "Pasangan dari " ?nama " : " ?pasangan crlf)
	(assert(pasangan ?nama ?pasangan)))

(defrule kepadaortu
	(nama ?target)
	(ayah ?target ?ayah)
	(ibu ?target ?ibu)
	=>
	(assert(wasiat(kepada ?ayah)(sebagai ayah)(persen 20)))
	(assert(wasiat(kepada ?ibu)(sebagai ibu)(persen 10))))

(defrule kepadaanak
	(nama ?target)
	(ayah ?anak ?target)
	=>
	(assert(wasiat(kepada ?anak)(sebagai anak)(persen 20))))

(defrule kepadaanaksaudara
	(nama ?target)
	(ayah ?target ?ayah)
	(ayah ?nama &~?target ?ayah)
	(ayah ?anaksaudara ?nama)
	=>
	(assert(wasiat(kepada ?anaksaudara)(sebagai anaksaudara)(persen 5))))

(defrule kepadapasangan
	(nama ?target)
	(pasangan ?target ?pasangan)
	=>
	(assert(wasiat(kepada ?pasangan)(sebagai pasangan)(persen 25))))

(defrule kepadacucu
	(nama ?target)
	(cucu ?target ?cucu)
	=>
	(assert(wasiat(kepada ?cucu)(sebagai cucu)(persen 5))))

(defrule kepadasaudara
	(nama ?target)
	(ayah ?target ?ayah)
	(ayah ?nama &~?target ?ayah)
	=>
	(assert(wasiat(kepada ?nama)(sebagai saudara)(persen 5))))

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
	(nama ?target)
	(kel(nama ?nama)(lokasi cipali))
	(benci(nama ?nama)(benci $? ?target $?))
	(tidaklebihkaya ?target ?nama1)
	(test (eq ?nama ?nama1))
	=>
	(assert (killer ?nama))
	(printout t "Nama Pembunuh : " ?nama crlf))

(defrule wasiat
	(wasiat(kepada ?kpd)(sebagai ?sbg)(persen ?persen))
	=>
	(printout t ?kpd " dapat " ?persen "% sebagai " ?sbg crlf))
