<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function edom_1_get_dosen_by_tahun($arr_tahun = NULL) {
        if ($arr_tahun != NULL) {
            //$where = 'WHERE je.tahun IN (';
            $where = 'WHERE j.TahunID IN (';
            foreach ($arr_tahun as $value) {
                $where .= $value.',';
            }
            $where = str_split($where, (strlen($where)-1));
            $where = $where[0].')';
        } else {
            $where = '';
        }
        if ($where != '') {
            /*$db_dflt = $this->load->database('default', TRUE);
            $sql = "SELECT je.DosenID, TRIM(je.Nama_Dosen) AS Nama_Dosen
                FROM jawaban_edom je
                ".$where."
                GROUP BY je.DosenID
                ORDER BY TRIM(je.Nama_Dosen)";*/
            $db_dflt = $this->load->database('sisfo', TRUE);
            $sql = "SELECT j.DosenID AS DosenID, TRIM(d.Nama) AS Nama_Dosen
                FROM krs k
                LEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID
                LEFT OUTER JOIN dosen d ON j.DosenID = d.Login
                ".$where."
                AND k.NA = 'N'
                GROUP BY j.DosenID
                ORDER BY TRIM(d.Nama)";
            $query = $db_dflt->query($sql);
            $db_dflt->close();
            if ($query->num_rows() > 0) {
                return $query->result();
            }
        }
        return FALSE;
    }
    
    function edom_1_get_mk_by_tahun_and_dosen($arr_tahun = NULL, $dosen_id = NULL) {
        if (($arr_tahun != NULL) && ($dosen_id != NULL)) {
            $where = 'WHERE k.TahunID IN (';
            foreach ($arr_tahun as $value) {
                $where .= $value.',';
            }
            $where = str_split($where, (strlen($where)-1));
            $where = $where[0].')';
            $where .= " AND j.DosenID = '".$dosen_id."'";
        } else {
            $where = '';
        }
        if ($where != '') {
            /*$db_dflt = $this->load->database('default', TRUE);
            $sql = "SELECT je.MKID, je.MKKode, je.Nama_MK, je.DosenID, je.Nama_Dosen
                FROM jawaban_edom je
                ".$where."
                GROUP BY je.MKID, je.DosenID, je.tahun";*/
            $db_dflt = $this->load->database('sisfo', TRUE);
            $sql = "SELECT CONCAT(k.MKKode,'&&',k.Nama) AS MKKode, CONCAT(k.MKKode,' - ',k.Nama) AS Nama_MK
                FROM krs k
                LEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID
                ".$where."
                AND k.NA = 'N'
                GROUP BY k.MKKode, k.Nama
                ORDER BY CONCAT(k.MKKode,' - ',k.Nama)";
            $query = $db_dflt->query($sql);
            $db_dflt->close();
            if ($query->num_rows() > 0) {
                return $query->result();
            }
        }
        return FALSE;
    }
    
    function edom_1_get_jadwal_by_tahun_and_dosen_and_mk($arr_tahun = NULL, $dosen_id = NULL, $mkkode = NULL, $mkname = NULL) {
        if (($arr_tahun != NULL) && ($dosen_id != NULL) && ($mkkode != NULL) && ($mkname != NULL)) {
            $where = 'WHERE k.TahunID IN (';
            foreach ($arr_tahun as $value) {
                $where .= $value.',';
            }
            $where = str_split($where, (strlen($where)-1));
            $where = $where[0].')';
            $where .= " AND j.DosenID = '".$dosen_id."'";
            $where .= " AND j.MKKode = '".$mkkode."'";
            $where .= " AND j.Nama LIKE '".$mkname."'";
        } else {
            $where = '';
        }
        if ($where != '') {
            $db_dflt = $this->load->database('sisfo', TRUE);
            $sql = "SELECT CONCAT(j.HariID,'&&',j.JamMulai,'&&',j.JamSelesai,'&&',j.RuangID) AS jadwal, CONCAT(h.Nama,', ',SUBSTRING(j.JamMulai,1,5),'-',SUBSTRING(j.JamSelesai,1,5),' (',j.RuangID,')') AS deskripsi
                FROM krs k
                LEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID
                LEFT OUTER JOIN hari h ON j.HariID = h.HariID
                ".$where."
                AND k.NA = 'N'
                GROUP BY j.HariID, j.JamMulai, j.JamSelesai, j.RuangID
                ORDER BY j.HariID, j.JamMulai";//GROUP BY CONCAT(j.HariID,'&&',j.JamMulai,'&&',j.JamSelesai,'&&',j.RuangID)
                
            //print_r($sql); exit();
            $query = $db_dflt->query($sql);
            $db_dflt->close();
            if ($query->num_rows() > 0) {
                return $query->result();
            }
        }
        return FALSE;
    }
    
    function edom_1_get_calc_data_each_pilihan($arr_TahunID = NULL, $DosenID = NULL, $mkkode = NULL, $mkname = NULL, $arr_jadwal = array()) {
        if (($arr_TahunID == NULL) &&
            ($DosenID == NULL) &&
            ($mkkode == NULL) &&
            ($mkname == NULL) &&
            ($arr_jadwal == array())) {
            return FALSE;
        }
        if (is_array($arr_TahunID)) {
            $where_TahunID = 'vv.TahunID IN (';
            foreach ($arr_TahunID as $value) {
                $where_TahunID .= $value.',';
            }
            $where_TahunID = str_split($where_TahunID, (strlen($where_TahunID)-1));
            $where_TahunID = $where_TahunID[0].')';
        } else {
            $where_TahunID = "vv.TahunID = '".$arr_TahunID."' ";
        }
        //print_r($arr_jadwal);
        if (is_array($arr_jadwal)) {
            $where_jadwal = 'AND (';
            foreach ($arr_jadwal as $value) {
                $where_jadwal .= "(vv.HariID = '".$value->HariID."'
                    AND vv.JamMulai = '".$value->JamMulai."'
                    AND vv.JamSelesai = '".$value->JamSelesai."'
                    AND vv.RuangID = '".$value->RuangID."')OR";
            }
            $where_jadwal = str_split($where_jadwal, (strlen($where_jadwal)-2));
            $where_jadwal = $where_jadwal[0].')';
        }
        //from sisfo
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT * FROM (
            SELECT vv.id_pertanyaan AS id, ROUND(AVG(p.nilai),2) AS nilai, mp.isi AS pertanyaan
            FROM jawaban_edom vv
            LEFT OUTER JOIN pilihan p ON vv.jawaban_pilihan = p.id_pilihan
            LEFT OUTER JOIN master_pertanyaan mp ON vv.id_pertanyaan = mp.id_pertanyaan
            WHERE ".$where_TahunID."
            AND vv.MKKode = '".$mkkode."'
            AND vv.Nama_MK LIKE '".$mkname."'
            AND vv.DosenID = '".$DosenID."'
            ".$where_jadwal."
            AND vv.jawaban_isian IS NULL
            GROUP BY vv.id_pertanyaan
            ORDER BY vv.id_pertanyaan ) vvv
            UNION
            SELECT 'TOTAL' AS id, ROUND(AVG(p.nilai),2) AS nilai, 'Rata-rata'
            FROM jawaban_edom vv
            LEFT OUTER JOIN pilihan p ON vv.jawaban_pilihan = p.id_pilihan
            WHERE ".$where_TahunID."
            AND vv.MKKode = '".$mkkode."'
            AND vv.Nama_MK LIKE '".$mkname."'
            AND vv.DosenID = '".$DosenID."'
            ".$where_jadwal."
            AND vv.jawaban_isian IS NULL";
        $query = $db_dflt->query($sql);
        //print_r($sql); exit();
        $db_dflt->close();
        if ($query->num_rows() > 1) {
            //print_r($query->result());
            return $query->result();
        }
        return FALSE;
    }
    
    function edom_1_get_isian_data_each_pertanyaan($arr_TahunID = NULL, $DosenID = NULL, $mkkode = NULL, $mkname = NULL, $arr_jadwal = array()) {
        if (($arr_TahunID == NULL) &&
            ($DosenID == NULL) &&
            ($mkkode == NULL) &&
            ($mkname == NULL) &&
            ($arr_jadwal == array())) {
            return FALSE;
        }
        if (is_array($arr_TahunID)) {
            $where_TahunID = 'vv.TahunID IN (';
            foreach ($arr_TahunID as $value) {
                $where_TahunID .= $value.',';
            }
            $where_TahunID = str_split($where_TahunID, (strlen($where_TahunID)-1));
            $where_TahunID = $where_TahunID[0].')';
        } else {
            $where_TahunID = "vv.TahunID = '".$arr_TahunID."' ";
        }
        //print_r($arr_jadwal);
        if (is_array($arr_jadwal)) {
            $where_jadwal = 'AND (';
            foreach ($arr_jadwal as $value) {
                $where_jadwal .= "(vv.HariID = '".$value->HariID."'
                    AND vv.JamMulai = '".$value->JamMulai."'
                    AND vv.JamSelesai = '".$value->JamSelesai."'
                    AND vv.RuangID = '".$value->RuangID."')OR";
            }
            $where_jadwal = str_split($where_jadwal, (strlen($where_jadwal)-2));
            $where_jadwal = $where_jadwal[0].')';
        }
        //from sisfo
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT * FROM (
            SELECT 
                vv.id_pertanyaan AS id,
                mp.isi AS konten,
                vv.id_pertanyaan * 10 + 1 AS order_no,
                'PILIHAN' AS tipe
            FROM
                jawaban_edom vv
                    LEFT OUTER JOIN
                master_pertanyaan mp ON vv.id_pertanyaan = mp.id_pertanyaan
            WHERE ".$where_TahunID."
                AND vv.MKKode = '".$mkkode."'
                AND vv.Nama_MK LIKE '".$mkname."'
                AND vv.DosenID = '".$DosenID."'
                ".$where_jadwal."
                    AND vv.jawaban_isian IS NOT NULL
            GROUP BY vv.id_pertanyaan 
            UNION SELECT 
                vv.id_pertanyaan AS id,
                vv.jawaban_isian AS konten,
                vv.id_pertanyaan * 10 + 2 AS order_no,
                'ISI' AS tipe
            FROM
                jawaban_edom vv
            WHERE ".$where_TahunID."
                AND vv.MKKode = '".$mkkode."'
                AND vv.Nama_MK LIKE '".$mkname."'
                AND vv.DosenID = '".$DosenID."'
                ".$where_jadwal."
                    AND vv.jawaban_isian IS NOT NULL
            ) vvv
            ORDER BY vvv.order_no";
        $query = $db_dflt->query($sql);
        //print_r($sql); exit();
        $db_dflt->close();
        if ($query->num_rows() > 1) {
            //print_r($query->result());
            return $query->result();
        }
        return FALSE;
    }
    
    function edom_1_get_respondent_data($arr_TahunID = NULL, $DosenID = NULL, $mkkode = NULL, $mkname = NULL, $arr_jadwal = array()) {
        if (($arr_TahunID == NULL) &&
            ($DosenID == NULL) &&
            ($mkkode == NULL) &&
            ($mkname == NULL) &&
            ($arr_jadwal == array())) {
            return FALSE;
        }
        if (is_array($arr_TahunID)) {
            $where_TahunID = 'vv.TahunID IN (';
            foreach ($arr_TahunID as $value) {
                $where_TahunID .= $value.',';
            }
            $where_TahunID = str_split($where_TahunID, (strlen($where_TahunID)-1));
            $where_TahunID = $where_TahunID[0].')';
        } else {
            $where_TahunID = "vv.TahunID = '".$arr_TahunID."' ";
        }
        //print_r($arr_jadwal);
        if (is_array($arr_jadwal)) {
            $where_jadwal = 'AND (';
            foreach ($arr_jadwal as $value) {
                $where_jadwal .= "(vv.HariID = '".$value->HariID."'
                    AND vv.JamMulai = '".$value->JamMulai."'
                    AND vv.JamSelesai = '".$value->JamSelesai."'
                    AND vv.RuangID = '".$value->RuangID."')OR";
            }
            $where_jadwal = str_split($where_jadwal, (strlen($where_jadwal)-2));
            $where_jadwal = $where_jadwal[0].')';
        }
        //from sisfo
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT vvv.respon_ke, COUNT(vvv.respondent_id) AS respondent
            FROM (
            SELECT vv.respon_ke, vv.respondent_id
            FROM jawaban_header_edom vv
            WHERE ".$where_TahunID."
            AND vv.MKKode = '".$mkkode."'
            AND vv.Nama_MK LIKE '".$mkname."'
            AND vv.DosenID = '".$DosenID."'
            ".$where_jadwal."
            GROUP BY vv.respon_ke, vv.respondent_id ) vvv
            GROUP BY vvv.respon_ke";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->result();
        }
        return FALSE;
    }