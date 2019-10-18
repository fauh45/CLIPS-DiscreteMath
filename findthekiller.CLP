(deftemplate kel
	(slot nama)
	(slot gender)
	(slot lokasi)
	(slot pasangan)
	(multislot ortu (default undefined))
	(multislot anak))

(deftemplate benci "hate bois"
	(slot nama)
	(multislot benci))

(deftemplate wasiat
	(slot kepada)
	(slot persen))

(deffacts cipali
	(kel(nama Adam)(gender Laki)(lokasi cipali)(ortu Dadang Ji))
	(kel(nama Muntu)(gender Laki)(lokasi cipali)(pasangan Xian)(anak Jar)(ortu Dadang Ji))
	(kel(nama Residivis)(gender Perempuan)(lokasi cipali)(ortu Dadang Ji)))

(deffacts cimahi
	(kel(nama Dadang)(gender Laki)(lokasi cimahi)(pasangan Ji)(anak Adam Muntu Residivis Ganjar))
	(kel(nama Ji)(gender Perempuan)(lokasi cimahi)(pasangan Dadang)(anak Adam Muntu Residivis Ganjar))
	(kel(nama Ganjar)(gender Laki)(lokasi cimahi)(ortu Dadang Ji)))

(deffacts jakarta
	(kel(nama Xian)(gender Perempuan)(lokasi cimahi)(pasangan Muntu)(anak Jar))
	(kel(nama Jar)(gender Laki)(lokasi cimahi)(ortu Xian Muntu)))

(deffacts wasiatmuntu
	(wasiat(kepada Dadang)(persen 25))
	(wasiat(kepada Ji)(persen 25))
	(wasiat(kepada Xian)(persen 30))
	(wasiat(kepada Jar)(persen 20)))

(defrule reflexive
	(kel(nama ?nama))
	=>
	(assert(tidaklebihkaya ?nama ?nama)))

;Muntu membenci semua kecuali Residivis

(defrule muntu
	(kel(nama ?name &~Residivis)(lokasi cipali))
	=>
	(assert(benci(nama Muntu)(benci ?name))))

;Adam tidak membenci satupun yang muntu benci

(defrule adam
	(kel(nama ?name)(lokasi cipali))
	(not(benci(nama Muntu)(benci ?name)))
	=>
	(assert(benci(nama Adam)(benci ?name))))

;Residivisi membenci semua yang Muntu benci dan semua yang tidak lebih kaya dari Muntu

(defrule residivis
	(benci(nama Muntu)(benci ?nama))
	(tidaklebihkaya Muntu ?nama)
	=>
	(assert(benci(nama Residivis)(benci ?nama))))

(defrule cucu
	(kel(nama ?nm)(ortu undefined)(anak $? ?anak $?))
	(kel(nama ?nama)(ortu $? ?anak $?))
	=>
	(printout t "Cucu dari " ?nm " : " ?nama crlf)
	(assert (cucu ?nama)))

(defrule nenek
	(cucu ?cucu)
	(kel(ortu $? ?nenek $?)(anak $? ?cucu $?))
	(kel(nama ?nenek)(gender Perempuan))
	=>
	(printout t "Nenek dari " ?cucu " adalah " ?nenek crlf))

(defrule kakek
	(cucu ?cucu)
	(kel(ortu $? ?kakek $?)(anak $? ?cucu $?))
	(kel(nama ?kakek)(gender Laki))
	=>
	(printout t "Kakek dari " ?cucu " adalah " ?kakek crlf))

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
