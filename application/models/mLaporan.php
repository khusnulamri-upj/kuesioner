<?php

class MLaporan extends CI_Model {

    function __construct() {
        // Call the Model constructor
        parent::__construct();
    }
    
    function edom_0_get_tahun() {
        //from sisfo
        $db_dflt = $this->load->database('sisfo', TRUE);
        $sql = "SELECT k.TahunID AS deskripsi, k.TahunID AS tahun
            FROM krs k
            GROUP BY k.TahunID
            ORDER BY k.TahunID DESC";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->result();
        }
        return FALSE;
    }
    
    function edom_0_process_rata2($arr_tahun = NULL) {
        
    }
    
    function edom_0_get_list_jadwal($arr_tahun = NULL) {
        $in_tahun = "IN (";
        if ($arr_tahun == NULL) {
            return FALSE;
        } else {
            foreach ($arr_tahun as $value) {
                $in_tahun .= $value.',';
            }
            $in_tahun = substr($in_tahun, 0, (strlen($in_tahun)-1));
        }
        $in_tahun .= ")";
        //from sisfo
        $db_dflt = $this->load->database('sisfo', TRUE);
        /*$sql = "SELECT *
            FROM (
            SELECT j.JadwalID, j.KodeID, j.TahunID, j.ProdiID, j.ProgramID, j.MKID, j.MKKode, j.Nama AS Nama_MK, j.HariID, h.Nama AS Hari, j.JamMulai, j.JamSelesai, j.RuangID,
            j.DosenID, d.Nama AS Nama_Dosen, 1 AS order_no
            FROM jadwal j
            LEFT OUTER JOIN dosen d ON j.DosenID = d.Login
            LEFT OUTER JOIN hari h ON j.HariID = h.HariID
            WHERE j.TahunID ".$in_tahun." AND j.NA = 'N'
            UNION
            SELECT j.JadwalID, j.KodeID, j.TahunID, j.ProdiID, j.ProgramID, j.MKID, j.MKKode, j.Nama AS Nama_MK, j.HariID, h.Nama AS Hari, j.JamMulai, j.JamSelesai, j.RuangID,
            jd.DosenID, d.Nama AS Nama_Dosen, 2 AS order_no
            FROM jadwal j
            LEFT OUTER JOIN jadwaldosen jd ON j.JadwalID = jd.JadwalID
            LEFT OUTER JOIN dosen d ON jd.DosenID = d.Login
            LEFT OUTER JOIN hari h ON j.HariID = h.HariID
            WHERE j.TahunID ".$in_tahun." AND j.NA = 'N'
            ) a
            WHERE a.DosenID IS NOT NULL
            GROUP BY a.TahunID, a.MKKode, a.Nama_MK, a.HariID, a.JamMulai, a.JamSelesai, a.RuangID, a.DosenID
            ORDER BY a.TahunID, a.MKKode, a.Nama_MK, a.HariID, a.JamMulai, a.JamSelesai, a.RuangID, a.order_no, a.Nama_Dosen";*/
        /*$sql = "SELECT a.TahunID, a.MKKode, a.Nama_MK, a.HariID, a.JamMulai, a.JamSelesai, a.RuangID, a.DosenID, a.order_no, h.nama AS Hari, d.Nama AS Nama_Dosen
            FROM (
            SELECT k.TahunID, UPPER(mk.MKKode) AS MKKode, UPPER(mk.Nama) AS Nama_MK, j.HariID, j.JamMulai, j.JamSelesai, j.RuangID, j.DosenID, 1 AS order_no
            FROM krs k
            LEFT OUTER JOIN jadwal j ON (k.JadwalID = j.JadwalID AND k.KodeID = j.KodeID)
            LEFT OUTER JOIN mk mk ON (j.MKID = mk.MKID AND k.KodeID = j.KodeID)
            WHERE k.NA = 'N'
            AND k.JadwalID <> 0
            AND k.TahunID ".$in_tahun."
            UNION
            SELECT k.TahunID, UPPER(mk.MKKode) AS MKKode, UPPER(mk.Nama) AS Nama_MK, j.HariID, j.JamMulai, j.JamSelesai, j.RuangID, jd.DosenID, 2 AS order_no
            FROM krs k
            LEFT OUTER JOIN jadwal j ON (k.JadwalID = j.JadwalID AND k.KodeID = j.KodeID)
            LEFT OUTER JOIN mk mk ON (j.MKID = mk.MKID AND k.KodeID = j.KodeID)
            RIGHT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID
            WHERE k.NA = 'N'
            AND k.JadwalID <> 0
            AND k.TahunID ".$in_tahun."
            ) a
            LEFT OUTER JOIN hari h ON a.HariID = h.HariID
            LEFT OUTER JOIN dosen d ON a.DosenID = d.Login
            WHERE a.MKKode IS NOT NULL OR a.Nama_MK IS NOT NULL 
            GROUP BY a.TahunID, a.MKKode, a.Nama_MK, a.HariID, a.JamMulai, a.JamSelesai, a.RuangID, a.DosenID
            ORDER BY a.TahunID, a.MKKode, a.Nama_MK, a.HariID, a.JamMulai, a.JamSelesai, a.RuangID, a.order_no, a.DosenID";*/
        $sql = "SELECT a.TahunID, a.MKKode, a.Nama_MK, a.HariID, a.JamMulai, a.JamSelesai, a.RuangID, a.DosenID, a.order_no, h.nama AS Hari, d.Nama AS Nama_Dosen
            FROM (
            SELECT k.TahunID, UPPER(j.MKKode) AS MKKode, UPPER(j.Nama) AS Nama_MK, j.HariID, j.JamMulai, j.JamSelesai, j.RuangID, j.DosenID, 1 AS order_no
            FROM krs k
            LEFT OUTER JOIN jadwal j ON (k.JadwalID = j.JadwalID AND k.KodeID = j.KodeID)
            WHERE k.NA = 'N'
            AND k.JadwalID <> 0
            AND k.TahunID ".$in_tahun."
            UNION
            SELECT k.TahunID, UPPER(j.MKKode) AS MKKode, UPPER(j.Nama) AS Nama_MK, j.HariID, j.JamMulai, j.JamSelesai, j.RuangID, jd.DosenID, 2 AS order_no
            FROM krs k
            LEFT OUTER JOIN jadwal j ON (k.JadwalID = j.JadwalID AND k.KodeID = j.KodeID)
            RIGHT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID
            WHERE k.NA = 'N'
            AND k.JadwalID <> 0
            AND k.TahunID ".$in_tahun."
            ) a
            LEFT OUTER JOIN hari h ON a.HariID = h.HariID
            LEFT OUTER JOIN dosen d ON a.DosenID = d.Login
            WHERE a.MKKode IS NOT NULL OR a.Nama_MK IS NOT NULL OR a.HariID IS NOT NULL OR a.JamMulai IS NOT NULL OR a.JamSelesai IS NOT NULL OR a.RuangID IS NOT NULL OR a.DosenID IS NOT NULL
            GROUP BY a.TahunID, a.MKKode, a.Nama_MK, a.HariID, a.JamMulai, a.JamSelesai, a.RuangID, a.DosenID
            ORDER BY a.TahunID, a.MKKode, a.Nama_MK, a.HariID, a.JamMulai, a.JamSelesai, a.RuangID, a.order_no, a.DosenID";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->result();
        }
        return FALSE;
    }
    
    /*function edom_0_get_calc_data_each_pilihan_per_jadwal($obj_parameter = NULL) {
        if ($obj_parameter == NULL) {
            return FALSE;
        }
        //from sisfo
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT * FROM (
            SELECT vv.id_pertanyaan AS id, ROUND(AVG(p.nilai),2) AS nilai
            FROM jawaban_edom vv
            LEFT OUTER JOIN pilihan p ON vv.jawaban_pilihan = p.id_pilihan
            WHERE vv.TahunID = '".$obj_parameter->TahunID."'
            AND vv.MKKode = '".$obj_parameter->MKKode."'
            AND vv.Nama_MK LIKE '".$obj_parameter->Nama_MK."'
            AND vv.HariID = '".$obj_parameter->HariID."'
            AND vv.JamMulai = '".$obj_parameter->JamMulai."'
            AND vv.JamSelesai = '".$obj_parameter->JamSelesai."'
            AND vv.RuangID = '".$obj_parameter->RuangID."'
            AND vv.DosenID = '".$obj_parameter->DosenID."'
            AND vv.jawaban_isian IS NULL
            GROUP BY vv.id_pertanyaan
            ORDER BY vv.id_pertanyaan ) vvv
            UNION
            SELECT 'FOOTER' AS id, ROUND(AVG(p.nilai),2) AS nilai
            FROM jawaban_edom vv
            LEFT OUTER JOIN pilihan p ON vv.jawaban_pilihan = p.id_pilihan
            WHERE vv.TahunID = '".$obj_parameter->TahunID."'
            AND vv.MKKode = '".$obj_parameter->MKKode."'
            AND vv.Nama_MK LIKE '".$obj_parameter->Nama_MK."'
            AND vv.HariID = '".$obj_parameter->HariID."'
            AND vv.JamMulai = '".$obj_parameter->JamMulai."'
            AND vv.JamSelesai = '".$obj_parameter->JamSelesai."'
            AND vv.RuangID = '".$obj_parameter->RuangID."'
            AND vv.DosenID = '".$obj_parameter->DosenID."'
            AND vv.jawaban_isian IS NULL";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 1) {
            //print_r($query->result());
            return $query->result();
        }
        return FALSE;
    }*/
    
    function edom_0_get_jadwal_id_per_jadwal($obj_parameter = NULL) {
        if ($obj_parameter == NULL) {
            return FALSE;
        }
        //from sisfo
        $db_dflt = $this->load->database('sisfo', TRUE);
        $sql = "SELECT k.TahunID, k.KodeID, k.JadwalID, j.ProdiID, j.DosenID AS DosenID
            FROM krs k
            LEFT OUTER JOIN jadwal j ON (k.JadwalID = j.JadwalID AND k.KodeID = j.KodeID)
            WHERE k.NA = 'N'
            AND k.JadwalID <> 0
            AND k.TahunID = '".$obj_parameter->TahunID."'
            AND UPPER(j.MKKode) = '".$obj_parameter->MKKode."'
            AND UPPER(j.Nama) = '".$obj_parameter->Nama_MK."'
            AND j.HariID = '".$obj_parameter->HariID."'
            AND j.JamMulai = '".$obj_parameter->JamMulai."'
            AND j.JamSelesai = '".$obj_parameter->JamSelesai."'
            AND j.RuangID = '".$obj_parameter->RuangID."'
            AND j.DosenID = '".$obj_parameter->DosenID."'
            UNION
            SELECT k.TahunID, k.KodeID, k.JadwalID, j.ProdiID, jd.DosenID AS DosenID
            FROM krs k
            LEFT OUTER JOIN jadwal j ON (k.JadwalID = j.JadwalID AND k.KodeID = j.KodeID)
            RIGHT OUTER JOIN jadwaldosen jd ON k.JadwalID = jd.JadwalID
            WHERE k.NA = 'N'
            AND k.JadwalID <> 0
            AND k.TahunID = '".$obj_parameter->TahunID."'
            AND UPPER(j.MKKode) = '".$obj_parameter->MKKode."'
            AND UPPER(j.Nama) = '".$obj_parameter->Nama_MK."'
            AND j.HariID = '".$obj_parameter->HariID."'
            AND j.JamMulai = '".$obj_parameter->JamMulai."'
            AND j.JamSelesai = '".$obj_parameter->JamSelesai."'
            AND j.RuangID = '".$obj_parameter->RuangID."'
            AND jd.DosenID = '".$obj_parameter->DosenID."'";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            //print_r($query->result());
            return $query->result();
        }
        return FALSE;
    }
    
    function edom_0_get_calc_data_each_pilihan_per_jadwal($obj_jadwal = NULL) {
        $in_jadwal_id = "IN (";
        if ($obj_jadwal == NULL) {
            return FALSE;
        } else {
            foreach ($obj_jadwal as $obj) {
                $in_jadwal_id .= $obj->JadwalID.',';
                $tahun_id = $obj->TahunID;
                $kode_id = $obj->KodeID;
                $dosen_id = $obj->DosenID;
            }
            $in_jadwal_id = substr($in_jadwal_id, 0, (strlen($in_jadwal_id)-1));
        }
        $in_jadwal_id .= ")";
        
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT vvv.id, vvv.nilai FROM (
            SELECT vv.id_pertanyaan AS id, ROUND(AVG(p.nilai),2) AS nilai
            FROM jawaban_edom_20131 vv
            LEFT OUTER JOIN pilihan p ON vv.jawaban_pilihan = p.id_pilihan
            WHERE SPLIT_STRING(vv.custom_data,'&&',1) = '".$tahun_id."'
            AND SPLIT_STRING(vv.custom_data,'&&',5) ".$in_jadwal_id."
            AND SPLIT_STRING(vv.custom_data,'&&',3) = '".$kode_id."'
            AND SPLIT_STRING(vv.custom_data,'&&',6) = '".$dosen_id."'
            AND vv.jawaban_isian IS NULL
            GROUP BY vv.id_pertanyaan
            ORDER BY vv.id_pertanyaan ) vvv
            UNION
            SELECT 'FOOTER' AS id, ROUND(AVG(p.nilai),2) AS nilai
            FROM jawaban_edom_20131 vv
            LEFT OUTER JOIN pilihan p ON vv.jawaban_pilihan = p.id_pilihan
            WHERE SPLIT_STRING(vv.custom_data,'&&',1) = '".$tahun_id."'
            AND SPLIT_STRING(vv.custom_data,'&&',5) ".$in_jadwal_id."
            AND SPLIT_STRING(vv.custom_data,'&&',3) = '".$kode_id."'
            AND SPLIT_STRING(vv.custom_data,'&&',6) = '".$dosen_id."'
            AND vv.jawaban_isian IS NULL";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 1) {
            //print_r($query->result());
            return $query->result();
        }
        return FALSE;
    }
    
    function edom_0_get_respondent_data_per_jadwal($obj_parameter = NULL) {
        //LAMA --START
        /*if ($obj_parameter == NULL) {
            return FALSE;
        }*/
        //LAMA --END
        $in_jadwal_id = "IN (";
        if ($obj_parameter == NULL) {
            return FALSE;
        } else {
            foreach ($obj_parameter as $obj) {
                $in_jadwal_id .= $obj->JadwalID.',';
                $tahun_id = $obj->TahunID;
                $kode_id = $obj->KodeID;
                $dosen_id = $obj->DosenID;
            }
            $in_jadwal_id = substr($in_jadwal_id, 0, (strlen($in_jadwal_id)-1));
        }
        $in_jadwal_id .= ")";
        //from sisfo
        $db_dflt = $this->load->database('default', TRUE);
        /*$sql = "SELECT vvv.respon_ke, COUNT(vvv.respondent_id) AS respondent
            FROM (
            SELECT vv.respon_ke, vv.respondent_id
            FROM jawaban_header_edom vv
            WHERE vv.TahunID = '".$obj_parameter->TahunID."'
            AND vv.MKKode = '".$obj_parameter->MKKode."'
            AND vv.Nama_MK LIKE '".$obj_parameter->Nama_MK."'
            AND vv.HariID = '".$obj_parameter->HariID."'
            AND vv.JamMulai = '".$obj_parameter->JamMulai."'
            AND vv.JamSelesai = '".$obj_parameter->JamSelesai."'
            AND vv.RuangID = '".$obj_parameter->RuangID."'
            AND vv.DosenID = '".$obj_parameter->DosenID."'
            GROUP BY vv.respon_ke, vv.respondent_id ) vvv
            GROUP BY vvv.respon_ke";*/
        $sql = "SELECT vvv.respon_ke, COUNT(vvv.respondent_id) AS respondent
            FROM (
            SELECT vv.respon_ke, vv.respondent_id
            FROM jawaban_header_edom vv
            WHERE vv.TahunID = '".$tahun_id."'
            AND vv.JadwalID ".$in_jadwal_id."
            AND vv.KodeID = '".$kode_id."'
            AND vv.DosenID = '".$dosen_id."'
            GROUP BY vv.respon_ke, vv.respondent_id ) vvv
            GROUP BY vvv.respon_ke";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->result();
        }
        return FALSE;
    }
    
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
            SELECT 'FOOTER' AS id, ROUND(AVG(p.nilai),2) AS nilai, 'Rata-rata'
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
                'PERTANYAAN' AS tipe
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
}

?>
