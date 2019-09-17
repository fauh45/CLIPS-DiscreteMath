(deftemplate kel
	(slot nama)
	(slot gender)
	(slot pasangan)
	(multislot ortu (default undefined))
	(multislot anak))

(deffacts keluarga
	(kel(nama adi)(gender laki)(pasangan jejeng)(anak alam edi mars))
	(kel(nama jejeng)(gender perempuan)(pasangan adi)(anak alam edi mars))
	(kel(nama alam)(gender laki)(ortu adi jejeng))
	(kel(nama edi)(gender laki)(ortu adi jejeng))
	(kel(nama mars)(gender perempuan)(pasangan jajang)(ortu adi jejeng)(anak venus merkuri))
	(kel(nama jajang)(gender laki)(pasangan mars)(ortu jared nicole)(anak venus merkuri))
	(kel(nama jared)(gender laki)(pasangan nicole)(anak jajang))
	(kel(nama nicole)(gender perempuan)(pasangan jared)(anak jajang))
	(kel(nama venus)(gender perempuan)(ortu mars jajang))
	(kel(nama merkuri)(gender laki)(ortu mars jajang)))

(defrule cucu
	(kel(nama ?nm)(ortu undefined)(anak $? ?anak $?))
	(kel(nama ?nama)(ortu $? ?anak $?))
	=>
	(printout t "Cucu dari " ?nm " : " ?nama crlf)
	(assert (cucu ?nama)))

(defrule nenek
	(cucu ?cucu)
	(kel(ortu $? ?nenek $?)(anak $? ?cucu $?))
	(kel(nama ?nenek)(gender perempuan))
	=>
	(printout t "Nenek dari " ?cucu " adalah " ?nenek crlf))

(defrule kakek
	(cucu ?cucu)
	(kel(ortu $? ?kakek $?)(anak $? ?cucu $?))
	(kel(nama ?kakek)(gender laki))
	=>
	(printout t "Kakek dari " ?cucu " adalah " ?kakek crlf)) 