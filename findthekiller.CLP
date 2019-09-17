(deftemplate benci "hate bois"
	(slot nama)
	(multislot benci))

(deffacts cipali
	(benci(nama Adam)(benci Residivis Muntu))
	(benci(nama Muntu)(benci Adam))
	(benci(nama Residivis)(benci Adam)))

(defrule cari
	(benci(nama ?nama)(benci $? Muntu $?))
	=>
	(assert (killer ?nama))
	(printout t "Nama Pembunuh : " ?nama crlf))
