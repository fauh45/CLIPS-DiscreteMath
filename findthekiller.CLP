(deftemplate kel
	(slot nama)
	(slot gender)
	(slot pasangan)
	(multislot ortu (default undefined))
	(multislot anak))

(deftemplate benci "hate bois"
	(slot nama)
	(slot lokasi)
	(multislot benci))

(deftemplate wasiat
	(slot kepada)
	(slot persen))

(deffacts cipali
	(kel(nama Adam)(gender Laki)(ortu Dadang Ji))
	(kel(nama Muntu)(gender Laki)(pasangan Xian)(anak Jar)(ortu Dadang Ji))
	(kel(nama Residivis)(gender Perempuan)(ortu Dadang Ji))
	(benci(nama Adam)(lokasi cipali)(benci Residivis))
	(benci(nama Muntu)(lokasi cipali)(benci Muntu Adam))
	(benci(nama Residivis)(lokasi cipali)(benci Muntu)))

(deffacts cimahi
	(kel(nama Dadang)(gender Laki)(pasangan Ji)(anak Adam Muntu Residivis Ganjar))
	(kel(nama Ji)(gender Perempuan)(pasangan Dadang)(anak Adam Muntu Residivis Ganjar))
	(kel(nama Ganjar)(gender Laki)(ortu Dadang Ji)))

(deffacts jakarta
	(kel(nama Xian)(gender Perempuan)(pasangan Muntu)(anak Jar))
	(kel(nama Jar)(gender Laki)(ortu Xian Muntu)))

(deffacts wasiatmuntu
	(wasiat(kepada Dadang)(persen 25))
	(wasiat(kepada Ji)(persen 25))
	(wasiat(kepada Xian)(persen 30))
	(wasiat(kepada Jar)(persen 20)))

(defrule reflexive
	(kel(nama ?nama))
	=>
	(assert(lebihkaya ?nama ?nama)))

(defrule cari
	(benci(nama ?nama)(lokasi cipali)(benci $? Muntu $?))
	(lebihkaya Muntu ?nama1)
	(test (eq ?nama ?nama1))
	=>
	(assert (killer ?nama))
	(printout t "Nama Pembunuh : " ?nama crlf))

(defrule wasiat
	(wasiat(kepada ?kpd)(persen ?persen))
	=>
	(printout t ?kpd " dapat " ?persen "%" crlf))
