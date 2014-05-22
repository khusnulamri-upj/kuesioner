<?php

class mlaporan extends CI_Model {

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
    
    function edom_0_get_processed_data($arr_tahun = NULL) {
        $tbl_laporan = 'edom_laporan';
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
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT a.TahunID, a.MKKode, a.Nama_MK, a.HariID, a.JamMulai, a.JamSelesai, a.RuangID, a.DosenID, a.order_no, a.Hari, a.Nama_Dosen, a.flag, a.flag_no, a.nilai, a.keterangan, a.prodi, a.respondent, a.created_at
            FROM ".$tbl_laporan." a
            WHERE a.modified_at IS NULL
            AND a.TahunID ".$in_tahun."
            AND a.nilai_isian IS NULL
            ORDER BY a.TahunID, a.MKKode, a.Nama_MK, a.HariID, a.JamMulai, a.JamSelesai, a.RuangID, a.order_no, a.DosenID, a.flag, a.flag_no";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->result();
        }
        return FALSE;
    }
    
    function edom_0_process_rata2($arr_tahun = NULL) {
        $tbl_laporan = 'edom_laporan';
        $edom_0_obj_jadwal = $this->edom_0_get_list_jadwal($arr_tahun);
        $db_dflt = $this->load->database('default', TRUE);
        $in_tahun = "IN (";
        if (($arr_tahun == NULL) || ($edom_0_obj_jadwal == FALSE)) {
            return FALSE;
        } else {
            foreach ($arr_tahun as $value) {
                $in_tahun .= $value.',';
            }
            $in_tahun = substr($in_tahun, 0, (strlen($in_tahun)-1));
        }
        $in_tahun .= ")";
        $db_dflt->trans_start();
        $sql = "UPDATE ".$tbl_laporan." l
            SET l.modified_at = NOW()
            WHERE l.TahunID ".$in_tahun;
        $db_dflt->query($sql);
        foreach ($edom_0_obj_jadwal as $obj) {
            //a.TahunID, a.MKKode, a.Nama_MK, a.HariID, a.JamMulai, a.JamSelesai, a.RuangID, a.DosenID, a.order_no, h.nama AS Hari, d.Nama AS Nama_Dosen
            $obj_jadwal_id = $this->edom_0_get_jadwal_id_per_jadwal($obj);
            //print_r('<br/>jadwal_id-----<br/>');
            //print_r($obj_jadwal_id);
            $obj_calc_data_isian = $this->edom_0_get_calc_data_each_pilihan_and_isian_per_jadwal($obj_jadwal_id);
            //print_r('<br/>calc_data-----<br/>');
            //print_r($obj_calc_data);
            //print_r('<br/>');
            $arr_respondent = $this->edom_0_get_respondent_data_per_jadwal($obj_jadwal_id);
            //get prodi
            $arr_prodi_id = array();
            $arr_list_jadwal_id = array();
            foreach ($obj_jadwal_id as $o) {
                $arr_prodi_id[] = $o->ProdiID;
                $arr_list_jadwal_id[] = $o->JadwalID;
            }
            
            sort($arr_prodi_id);
            sort($arr_list_jadwal_id);
            $prodi_id = '';
            $list_jadwal_id = '';
            $str_respondent = '';
            foreach ($arr_prodi_id as $o) {
                $prodi_id .= $o.', ';
            }
            $prodi_id = substr($prodi_id, 0, (strlen($prodi_id)-2));
            foreach ($arr_list_jadwal_id as $o) {
                $list_jadwal_id .= $o.', ';
            }
            $list_jadwal_id = substr($list_jadwal_id, 0, (strlen($list_jadwal_id)-2));
            
            $arr_obj_to_save = $obj;
            $arr_obj_to_save->prodi = $prodi_id;
            $arr_obj_to_save->JadwalID = $list_jadwal_id;
            
            if (is_array($arr_respondent)) {
                foreach ($arr_respondent as $o) {
                    $str_respondent .= $o->respondent.'<sup>'.$o->respon_ke.'</sup> ';
                }
                $arr_obj_to_save->respondent = $str_respondent;
            }
            if ($obj_calc_data_isian) {
                foreach ($obj_calc_data_isian as $obj2) {
                    $arr_obj_to_save->id_pertanyaan = $obj2->id_pertanyaan;
                    $arr_obj_to_save->flag = $obj2->id;
                    $arr_obj_to_save->flag_no = $obj2->flag_no;
                    $arr_obj_to_save->nilai = $obj2->nilai;
                    $arr_obj_to_save->keterangan = $obj2->keterangan;
                    $arr_obj_to_save->nilai_isian = $obj2->nilai_isian;
                    $db_dflt->insert($tbl_laporan, $arr_obj_to_save);
                }
            } else {
                $arr_obj_to_save->flag = 'NONE';
                $arr_obj_to_save->flag_no = 0;
                $arr_obj_to_save->nilai = 0;
                $db_dflt->insert($tbl_laporan, $arr_obj_to_save);
            }
        }
        $db_dflt->trans_complete();
        $db_dflt->close();
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
    
    function edom_0_get_sql_case_grade($col_name = NULL,$id_grup_pilihan = NULL) {
        $tbl_grade = 'penilaian';
        $count_bracket = 0;
        $sql_case = '';
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT a.min_nilai, a.max_nilai, a.deskripsi "
                . "FROM ".$tbl_grade." a "
                . "WHERE a.id_grup_pilihan=".$id_grup_pilihan." "
                . "ORDER BY a.min_nilai ASC";
        $query = $db_dflt->query($sql);
        foreach ($query->result() AS $obj) {
            $sql_case .= 'IF('.$col_name.'>='.$obj->min_nilai.' AND '.$col_name.'<='.$obj->max_nilai.', \''.$obj->deskripsi.'\',';
            $count_bracket++;
        }
        $sql_case .= '\'None\'';
        for ($index = 0; $index < $count_bracket; $index++) {
            $sql_case .= ')';
        }
        //print_r($sql_case);
        return $sql_case;
    }
    
    //tahunID = kolom deskripsi_detail dari tabel periode
    function edom_0_get_periode_data($tahunID) {
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT a.separator, a.tabel_jawaban, a.tabel_jawaban_header "
                . "FROM periode a "
                . "WHERE a.deskripsi_detail=".$tahunID;
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() == 1) {
            return $query->row();
        }
        return FALSE;
    }
    
    function edom_0_get_calc_data_each_pilihan_and_isian_per_jadwal($obj_jadwal = NULL) {
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
        
        $obj_periode = $this->edom_0_get_periode_data($tahun_id);
        
        if ($obj_periode == FALSE) {
            return FALSE;
        }
        //print_r($prodi_id);
        //exit();
        
        $sql_grade = ', ';
        $sql_grade .= $this->edom_0_get_sql_case_grade('vvv.nilai',1);
        $sql_grade .= ' AS keterangan ';
        
        $sql_grade2 = ', ';
        $sql_grade2 .= $this->edom_0_get_sql_case_grade('ROUND(AVG(p.nilai),2)',1);
        $sql_grade2 .= ' AS keterangan ';
        
        $db_dflt = $this->load->database('default', TRUE);
        $db_dflt->trans_start();
        $sql = "SELECT vvv.id AS id_pertanyaan, 'PILIHAN' AS id, vvv.order AS flag_no, vvv.nilai, NULL AS nilai_isian".$sql_grade."
            FROM (
                SELECT vv.id_pertanyaan AS id, ROUND(AVG(p.nilai),2) AS nilai, mp.order
                FROM ".$obj_periode->tabel_jawaban." vv
                LEFT OUTER JOIN pilihan p ON vv.jawaban_pilihan = p.id_pilihan
                LEFT OUTER JOIN master_pertanyaan mp ON vv.id_pertanyaan = mp.id_pertanyaan
                WHERE SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',1) = '".$tahun_id."'
                AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',5) ".$in_jadwal_id."
                AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',3) = '".$kode_id."'
                AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',6) = '".$dosen_id."'
                AND vv.jawaban_isian IS NULL
                GROUP BY vv.id_pertanyaan
                ORDER BY vv.id_pertanyaan ) vvv
            UNION
            SELECT NULL AS id_pertanyaan, 'TOTAL' AS id, 0 AS flag_no, ROUND(AVG(p.nilai),2) AS nilai, NULL AS nilai_isian".$sql_grade2."
            FROM ".$obj_periode->tabel_jawaban." vv
            LEFT OUTER JOIN pilihan p ON vv.jawaban_pilihan = p.id_pilihan
            WHERE SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',1) = '".$tahun_id."'
            AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',5) ".$in_jadwal_id."
            AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',3) = '".$kode_id."'
            AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',6) = '".$dosen_id."'
            AND vv.jawaban_isian IS NULL
            UNION
            SELECT vv.id_pertanyaan AS id_pertanyaan, 'ISIAN' AS id, mp.order AS flag_no, 0 AS nilai, vv.jawaban_isian AS nilai_isian, NULL AS keterangan
            FROM ".$obj_periode->tabel_jawaban." vv
            LEFT OUTER JOIN pilihan p ON vv.jawaban_pilihan = p.id_pilihan
            LEFT OUTER JOIN master_pertanyaan mp ON vv.id_pertanyaan = mp.id_pertanyaan
            WHERE SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',1) = '".$tahun_id."'
            AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',5) ".$in_jadwal_id."
            AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',3) = '".$kode_id."'
            AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',6) = '".$dosen_id."'
            AND vv.jawaban_isian IS NOT NULL";
        $query = $db_dflt->query($sql);
        
        $sql2 = "UPDATE ".$obj_periode->tabel_jawaban." vv
            SET vv.processed = 1
            WHERE SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',1) = '".$tahun_id."'
            AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',5) ".$in_jadwal_id."
            AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',3) = '".$kode_id."'
            AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',6) = '".$dosen_id."'
            AND vv.jawaban_isian IS NULL";
        $query2 = $db_dflt->query($sql2);
        
        $sql3 = "UPDATE ".$obj_periode->tabel_jawaban." vv
            SET vv.processed = 1
            WHERE SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',1) = '".$tahun_id."'
            AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',5) ".$in_jadwal_id."
            AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',3) = '".$kode_id."'
            AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',6) = '".$dosen_id."'
            AND vv.jawaban_isian IS NOT NULL";
        $query3 = $db_dflt->query($sql3);
        $db_dflt->trans_complete();
        $db_dflt->close();
        if ($query->num_rows() > 1) {
            //print_r($query->result());
            //exit();
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
        
        $obj_periode = $this->edom_0_get_periode_data($tahun_id);
        
        if ($obj_periode == FALSE) {
            return FALSE;
        }
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
            FROM ".$obj_periode->tabel_jawaban_header." vv
            WHERE SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',1) = '".$tahun_id."'
            AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',5) ".$in_jadwal_id."
            AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',3) = '".$kode_id."'
            AND SPLIT_STRING(vv.custom_data,'".$obj_periode->separator."',6) = '".$dosen_id."'
            GROUP BY vv.respon_ke, vv.respondent_id ) vvv
            GROUP BY vvv.respon_ke";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->result();
        }
        return FALSE;
    }
    
    function edom_1_get_processed_data($arr_tahun = NULL) {
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
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT a.TahunID, a.MKKode, a.Nama_MK, a.HariID, a.JamMulai, a.JamSelesai, a.RuangID, a.DosenID, a.order_no, a.Hari, a.Nama_Dosen, a.flag, a.flag_no, a.nilai, a.keterangan
            FROM edom_laporan a
            WHERE a.modified_at IS NULL
            AND a.TahunID ".$in_tahun."
            ORDER BY a.TahunID, a.MKKode, a.Nama_MK, a.HariID, a.JamMulai, a.JamSelesai, a.RuangID, a.order_no, a.DosenID, a.flag, a.flag_no";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->result();
        }
        return FALSE;
    }
    
    //AMR20140507 --START
    function edom_1_get_dosen_from_processed() {
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT e.DosenID AS DosenID, e.Nama_Dosen AS Nama_Dosen
            FROM edom_laporan e
            WHERE e.modified_at IS NULL
            GROUP BY e.DosenID, e.Nama_Dosen
            ORDER BY e.Nama_Dosen";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->result();
        }
        return FALSE;
    }
    
    function edom_1_get_jadwal_by_dosen_and_tahun_from_processed($dosen_id = NULL, $arr_tahun = NULL) {
        if ($arr_tahun != NULL) {
            $in_tahun = ' AND l.TahunID IN (';
            foreach ($arr_tahun as $value) {
                $in_tahun .= $value.',';
            }
            $in_tahun = str_split($in_tahun, (strlen($in_tahun)-1));
            $in_tahun = $in_tahun[0].') ';
        } else {
            $in_tahun = '';
            return false;
        }
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT l.TahunID, l.MKKode, l.Nama_MK, l.HariID, l.Hari, l.JamMulai, l.JamSelesai, l.RuangID, l.DosenID, l.Nama_Dosen, l.flag, l.nilai, l.keterangan, l.created_at
            FROM edom_laporan l
            WHERE l.DosenID = '".$dosen_id."'
            AND l.modified_at IS NULL
            AND l.flag IN ('NONE','TOTAL')".$in_tahun."
            GROUP BY l.TahunID, l.MKKode, l.Nama_MK, l.HariID, l.JamMulai, l.JamSelesai, l.RuangID;";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->result();
        }
        return FALSE;
    }
    
    function edom_1_get_detail_pilihan_from_processed($dosen_id = NULL, $tahunID = NULL, $mk_kode = NULL, $nama_mk = NULL, $hariID = NULL, $jamMulai = NULL, $jamSelesai = NULL, $ruangID = NULL) {
        /*if ($arr_tahun != NULL) {
            $in_tahun = ' AND l.TahunID IN (';
            foreach ($arr_tahun as $value) {
                $in_tahun .= $value.',';
            }
            $in_tahun = str_split($in_tahun, (strlen($in_tahun)-1));
            $in_tahun = $in_tahun[0].') ';
        } else {
            $in_tahun = '';
            return false;
        }*/
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT * FROM (
            SELECT l.TahunID, l.MKKode, l.Nama_MK, l.HariID, l.Hari, l.JamMulai, l.JamSelesai, l.RuangID, l.DosenID, l.Nama_Dosen, l.prodi, l.flag_no, l.nilai, l.keterangan, l.respondent, mp.isi AS pertanyaan, l.id_pertanyaan AS id_pertanyaan, l.created_at
            FROM edom_laporan l
            LEFT OUTER JOIN master_pertanyaan mp ON l.id_pertanyaan = mp.id_pertanyaan
            WHERE l.flag = 'PILIHAN' 
            AND l.TahunID = '".$tahunID."'
            AND l.MKKode = '".$mk_kode."'
            AND l.Nama_MK = '".$nama_mk."'
            AND l.HariID = '".$hariID."'
            AND l.JamMulai = '".$jamMulai."'
            AND l.JamSelesai = '".$jamSelesai."'
            AND l.RuangID = '".$ruangID."'
            AND l.DosenID = '".$dosen_id."'
            AND l.modified_at IS NULL
            ORDER BY l.flag_no) o
            UNION
            SELECT l.TahunID, l.MKKode, l.Nama_MK, l.HariID, l.Hari, l.JamMulai, l.JamSelesai, l.RuangID, l.DosenID, l.Nama_Dosen, l.prodi, l.flag_no, l.nilai, l.keterangan, l.respondent, 'Rata-rata' AS pertanyaan, 0 AS id_pertanyaan, l.created_at
            FROM edom_laporan l
            WHERE l.flag = 'TOTAL'
            AND l.TahunID = '".$tahunID."'
            AND l.MKKode = '".$mk_kode."'
            AND l.Nama_MK = '".$nama_mk."'
            AND l.HariID = '".$hariID."'
            AND l.JamMulai = '".$jamMulai."'
            AND l.JamSelesai = '".$jamSelesai."'
            AND l.RuangID = '".$ruangID."'
            AND l.DosenID = '".$dosen_id."'
            AND l.modified_at IS NULL";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->result();
        }
        return FALSE;
    }
    
    function edom_1_get_detail_penilaian($id_pertanyaan = NULL) {
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT p.deskripsi, ROUND(p.min_nilai,2) AS min_nilai, ROUND(p.max_nilai,2) AS max_nilai, p.id_grup_pilihan
            FROM master_pertanyaan mp
            JOIN penilaian p ON mp.id_grup_pilihan = p.id_grup_pilihan
            WHERE mp.id_pertanyaan = ".$id_pertanyaan."
            UNION
            SELECT p.deskripsi, ROUND(p.min_nilai,2) AS min_nilai, ROUND(p.max_nilai,2) AS max_nilai, p.id_grup_pilihan
            FROM master_pertanyaan mp
            JOIN penilaian p ON mp.id_grup_pilihan2 = p.id_grup_pilihan
            WHERE mp.id_pertanyaan = ".$id_pertanyaan;
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        $arr = array();
        if ($query->num_rows() > 0) {
            foreach ($query->result() as $r) {
                if (!array_key_exists($r->id_grup_pilihan, $arr)) {
                    $arr[$r->id_grup_pilihan] = array();
                }
                $arr[$r->id_grup_pilihan][] = new stdClass();
                $indx = count($arr[$r->id_grup_pilihan])-1;
                $arr[$r->id_grup_pilihan][$indx]->deskripsi = $r->deskripsi;
                $arr[$r->id_grup_pilihan][$indx]->min_nilai = $r->min_nilai;
                $arr[$r->id_grup_pilihan][$indx]->max_nilai = $r->max_nilai;
            }
            return $arr;
        }
        return FALSE;
    }
    
    function edom_1_get_detail_isian_from_processed($dosen_id = NULL, $tahunID = NULL, $mk_kode = NULL, $nama_mk = NULL, $hariID = NULL, $jamMulai = NULL, $jamSelesai = NULL, $ruangID = NULL) {
        /*if ($arr_tahun != NULL) {
            $in_tahun = ' AND l.TahunID IN (';
            foreach ($arr_tahun as $value) {
                $in_tahun .= $value.',';
            }
            $in_tahun = str_split($in_tahun, (strlen($in_tahun)-1));
            $in_tahun = $in_tahun[0].') ';
        } else {
            $in_tahun = '';
            return false;
        }*/
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT o.* FROM
            (SELECT mp.order*10+1 AS ordr, l.flag_no AS num, mp.isi AS isi, l.TahunID, l.MKKode, l.Nama_MK, l.HariID, l.Hari, l.JamMulai, l.JamSelesai, l.RuangID, l.DosenID, l.Nama_Dosen, l.flag_no, l.id_pertanyaan AS id_pertanyaan, mp.isi AS pertanyaan, l.created_at
            FROM edom_laporan l
            LEFT OUTER JOIN master_pertanyaan mp ON l.id_pertanyaan = mp.id_pertanyaan
            WHERE l.flag = 'ISIAN' 
            AND l.TahunID = '".$tahunID."'
            AND l.MKKode = '".$mk_kode."'
            AND l.Nama_MK = '".$nama_mk."'
            AND l.HariID = '".$hariID."'
            AND l.JamMulai = '".$jamMulai."'
            AND l.JamSelesai = '".$jamSelesai."'
            AND l.RuangID = '".$ruangID."'
            AND l.DosenID = '".$dosen_id."'
            AND l.modified_at IS NULL
            GROUP BY mp.order
            UNION ALL
            SELECT mp.order*10+2 AS ordr, 0 AS num, l.nilai_isian AS isi, l.TahunID, l.MKKode, l.Nama_MK, l.HariID, l.Hari, l.JamMulai, l.JamSelesai, l.RuangID, l.DosenID, l.Nama_Dosen, l.flag_no, l.id_pertanyaan AS id_pertanyaan, mp.isi AS pertanyaan, l.created_at
            FROM edom_laporan l
            LEFT OUTER JOIN master_pertanyaan mp ON l.id_pertanyaan = mp.id_pertanyaan
            WHERE l.flag = 'ISIAN' 
            AND l.TahunID = '".$tahunID."'
            AND l.MKKode = '".$mk_kode."'
            AND l.Nama_MK = '".$nama_mk."'
            AND l.HariID = '".$hariID."'
            AND l.JamMulai = '".$jamMulai."'
            AND l.JamSelesai = '".$jamSelesai."'
            AND l.RuangID = '".$ruangID."'
            AND l.DosenID = '".$dosen_id."'
            AND l.modified_at IS NULL) o
            ORDER BY o.ordr, o.created_at";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->result();
        }
        return FALSE;
    }
    //AMR20140507 --END
    
    
}

?>
