(deftemplate kel
	(slot nama)
	(slot gender)
	(slot pasangan)
	(multislot ortu (default undefined))
	(multislot anak))

(deftemplate benci "hate bois"
	(slot nama)
	(slot kaya)
	(multislot benci))

(deffacts cipali
	(nama Adam)(gender Laki)(ortu Dadang Ji)
	(nama Muntu)(gender Laki)(ortu Dadang Ji)
	(nama Residivis)(gender Perempuan)(ortu Dadang Ji))

(deffacts cimahi
	(nama Dadang)(gender Laki)(pasangan Ji)(anak Adam Muntu Residivis Ganjar)
	(nama Ji)(gender Perempuan)(pasangan Dadang)(anak Adam Muntu Residivis Ganjar)
	(nama Ganjar)(gender Laki)(ortu Dadang Ji))

(deffacts cipali "HATE"
	(benci(nama Adam)(kaya x1)(benci Residivis))
	(benci(nama Muntu)(kaya x2)(benci Muntu Adam))
	(benci(nama Residivis)(kaya x3)(benci Muntu)))

(defrule carikaya
	(benci(nama ?nama)(kaya ?kaya))
	(benci(nama ?nama1)(kaya ?kaya1))
	(test(>= ?kaya ?kaya1))
	=>
	(assert(lebihkaya ?nama ?nama1)))

(defrule cari
	(benci(nama ?nama)(benci $? Muntu $?))
	(lebihkaya Muntu ?nama1)
	(test(= ?nama ?nama1))
	=>
	(assert (killer ?nama))
	(printout t "Nama Pembunuh : " ?nama crlf))
