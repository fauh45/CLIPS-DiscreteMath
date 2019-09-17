(deftemplate kel (slot nama) (slot tgl-lahir) (slot gender) (multislot tekanan-darah) (slot berat))

(deffacts keluarga (kel (nama Yuda) (tgl-lahir 26021945) (gender laki) (tekanan-darah 110 80)(berat 68))
(kel (nama Adi) (tgl-lahir 26011970) (gender laki) (tekanan-darah 120 80)(berat 120))
(kel (nama Ruslan) (tgl-lahir 26111950) (gender laki) (tekanan-darah 120 80)(berat 75))
(kel (nama Ujang) (tgl-lahir 26121980) (gender laki) (tekanan-darah 100 80)(berat 89))
(kel (nama Dadang) (tgl-lahir 11022001) (gender laki) (tekanan-darah 100 80)(berat 80))
(kel (nama Marshanda) (tgl-lahir 01012002) (gender perempuan) (tekanan-darah 120 80)(berat 55))
(kel (nama Titi) (tgl-lahir 22011950) (gender perempuan) (tekanan-darah 120 70)(berat 67))
(kel (nama Husri) (tgl-lahir 23121990) (gender laki) (tekanan-darah 120 80)(berat 120))
(kel (nama Alam) (tgl-lahir 26022001) (gender laki) (tekanan-darah 100 60)(berat 78))
(kel (nama Edi) (tgl-lahir 25021990) (gender laki) (tekanan-darah 120 80)(berat 76))
(kel (nama Jejeng) (tgl-lahir 01011995) (gender perempuan) (tekanan-darah 120 80)(berat 45)))

(defrule wanita "cek wanita"
	(kel(nama ?d)(gender perempuan))
	=>
	(assert (wanita ?d))
	(printout t ?d " adalah wanita" crlf)
)

(defrule pria "cek pria"
	(kel(nama ?y)(gender laki))
	=>
	(assert(pria ?y))
	(printout t ?y " adalah pria" crlf)
)

(defrule sehat "cek tekanan darah"
	(kel(nama ?j)(tekanan-darah ?x ?y))
	(or(test(< ?x 120))
	(test(< ?y 80)))
	=>
	(assert(kurang sehat ?j))
	(printout t ?j " kurang sehat" crlf)
)

(defrule berat
	(kel(nama ?j)(berat ?b))
	(test(> ?b 100))
	=>
	(assert(terlalu berat ?j))
	(printout t ?j " terlalu berat" crlf)
)