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
        $sql = "SELECT *
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
            ORDER BY a.TahunID, a.MKKode, a.Nama_MK, a.HariID, a.JamMulai, a.JamSelesai, a.RuangID, a.order_no, a.Nama_Dosen";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->result();
        }
        return FALSE;
    }
    
    function edom_0_get_calc_data_each_pilihan_per_jadwal($obj_parameter = NULL) {
        if ($obj_parameter == NULL) {
            return FALSE;
        }
        //from sisfo
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT vv.id_pertanyaan, ROUND(AVG(p.nilai),2) AS rata_rata
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
            GROUP BY vv.id_pertanyaan";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->result();
        }
        return FALSE;
    }
    
    function edom_0_get_respondent_data_per_jadwal($obj_parameter = NULL) {
        if ($obj_parameter == NULL) {
            return FALSE;
        }
        //from sisfo
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT vvv.respon_ke, COUNT(vvv.respondent_id) AS respondent
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
            GROUP BY vvv.respon_ke";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->result();
        }
        return FALSE;
    }
    
    function edom_get_tahun() {
        //from jawaban
        /*$db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT mk.shortname, je.tahun AS tahun, je.tahun AS deskripsi
            FROM jawaban_edom je
            LEFT OUTER JOIN master_kuesioner mk ON je.id_kuesioner = mk.id_kuesioner
            WHERE mk.shortname = 'EDOM'
            GROUP BY je.tahun
            ORDER BY je.tahun DESC";*/
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
    
    function edom_get_dosen_by_tahun($arr_tahun = NULL) {
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
    
    function edom_get_mk_by_tahun_and_dosen($arr_tahun = NULL, $dosen_id = NULL) {
        if ($arr_tahun != NULL) {
            $where = 'WHERE k.TahunID IN (';
            foreach ($arr_tahun as $value) {
                $where .= $value.',';
            }
            $where = str_split($where, (strlen($where)-1));
            $where = $where[0].')';
            if ($dosen_id != NULL) {
                $where .= "AND j.DosenID = '".$dosen_id."'";
            }
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
            $sql = "SELECT k.MKKode AS MKKode, CONCAT(k.MKKode,' - ',k.Nama) AS Nama_MK
                FROM krs k
                LEFT OUTER JOIN jadwal j ON k.JadwalID = j.JadwalID
                ".$where."
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
    
    function edom_list_per_dosen_per_mk() {
        $arr_obj_return = array();
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT *
            FROM periode p
            LEFT OUTER JOIN master_kuesioner mk ON mk.id_kuesioner = p.id_kuesioner
            WHERE p.waktu_min < NOW() AND p.waktu_maks > NOW() AND mk.shortname = 'EDOM'";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            //return $query->result();
            //print_r($query->result());
            //exit();
            foreach ($query->result() as $row) {
                //CREATE ALL LIST KUESIONER AVAIBLE FOR THIS RESPONDENT_ID
                if ((strpos($row->respondent_id,'()') === FALSE) || (strpos($row->generator_config,'db=') === FALSE) || (strpos($row->generator_config,'sql=') === FALSE)) {
                    exit('Please check your config. #periode');
                }
                if (!empty($row->generator_config)) {
                    //menjalankan query dari config untuk me-generate form kuesioner
                    $str_func = str_replace('()', '', $row->respondent_id);
                    $arr_conf_db = explode(';',$row->generator_config);
                    $db_name = str_replace('"', '', str_replace('db=', '', $arr_conf_db[0]));
                    $db_query = str_replace('"', '', str_replace('sql=', '', $arr_conf_db[1]));
                    $db_tmp = $this->load->database($db_name, TRUE);
                    $sql_tmp = str_replace('{respondent_id}', $str_func(), $db_query);
                    $qry_tmp = $db_tmp->query($sql_tmp);
                    $db_tmp->close();
                    foreach ($qry_tmp->result() as $row_tmp) {
                        //membuat string data yang akan disimpan dalam database
                        $str_to_save = $row->custom_data_format;
                        $arr_field_save = explode(';', $str_to_save);
                        $deskripsi_return = $row->deskripsi;
                        foreach($arr_field_save as $value) {
                            if ((strpos($value,'{') !== FALSE) && (strpos($value,'}') !== FALSE)) {
                                $field_save = str_replace('}', '', str_replace('{', '', $value));
                                $str_to_save = str_replace($value, $row_tmp->$field_save, $str_to_save);
                                $deskripsi_return = str_replace($value, $row_tmp->$field_save, $deskripsi_return);
                            }
                        }
                        //membuat string data yang akan digunakan dalam coding
                        $str_to_throw = $row->data_helper;
                        $arr_field_throw = explode(';', $str_to_throw);
                        foreach($arr_field_throw as $value) {
                            if ((strpos($value,'{') !== FALSE) && (strpos($value,'}') !== FALSE)) {
                                $field_throw = str_replace('}', '', str_replace('{', '', $value));
                                $str_to_throw = str_replace($value, $field_throw.'='.$row_tmp->$field_throw, $str_to_throw);
                            }
                        }
                        $arr_obj_return[] = (object) array(
                            'id_periode' => $row->id_periode,
                            'id_kuesioner' => $row->id_kuesioner,
                            'deskripsi' => $deskripsi_return,
                            'custom_data' => $str_to_save,
                            'respondent_id' => $str_func(),
                            'throwed_data' => $str_to_throw
                        );
                    }
                }
                //DELETE KUESIONER THAT HAS BEEN FILLED
                $db_delete = $this->load->database('default', TRUE);
                $sql_delete = "SELECT j.id_periode, j.id_kuesioner, j.respondent_id, j.custom_data
                    FROM jawaban j
                    GROUP BY j.id_periode, j.id_kuesioner, j.respondent_id, j.custom_data";
                $qry_delete = $db_delete->query($sql_delete);
                $db_delete->close();
                $return = array();
                foreach ($arr_obj_return as $obj_ori) {
                    $obj_ori->is_filled = TRUE;
                    $is_diff = TRUE;
                    foreach ($qry_delete->result() as $obj_del) {
                        if (($obj_del->id_periode == $obj_ori->id_periode) &&
                                ($obj_del->id_kuesioner == $obj_ori->id_kuesioner) &&
                                ($obj_del->respondent_id == $obj_ori->respondent_id) &&
                                ($obj_del->custom_data == $obj_ori->custom_data)) {
                            $is_diff = FALSE;
                        }
                    }
                    //print_r($is_diff);
                    if ($is_diff) {
                        $obj_ori->is_filled = FALSE;
                    }
                    $return[] = $obj_ori;
                }
            }
            //$a = $query->result();
            //$a = array_merge($a,$query->result());
            //print_r($a);
            //exit();
            return $return;
        }
        return FALSE;
    }
    
    function get_kuesioner_data($id_for_search, $id_periode_for_search) {
        if (!empty($id_for_search)) {
            $db_dflt = $this->load->database('default', TRUE);
            $sql = "SELECT p.deskripsi, p.respondent_id, mk.custom_header, p.custom_data_format, MAX(pp.jml_pilihan) AS jml_pilihan, MAX(pp2.jml_pilihan2) AS jml_pilihan2
                FROM periode p
                LEFT OUTER JOIN master_kuesioner mk ON mk.id_kuesioner = p.id_kuesioner
                LEFT OUTER JOIN master_pertanyaan mp ON p.id_kuesioner = mp.id_kuesioner
                LEFT OUTER JOIN ( 
                SELECT p.id_grup_pilihan, count(*) AS jml_pilihan 
                FROM pilihan p 
                GROUP BY p.id_grup_pilihan 
                ) pp ON mp.id_grup_pilihan = pp.id_grup_pilihan
                LEFT OUTER JOIN ( 
                SELECT p2.id_grup_pilihan, count(*) AS jml_pilihan2 
                FROM pilihan p2 
                GROUP BY p2.id_grup_pilihan 
                ) pp2 ON mp.id_grup_pilihan2 = pp2.id_grup_pilihan
                WHERE mk.id_kuesioner = ".$id_for_search." AND p.id_periode = ".$id_periode_for_search;
            $query = $db_dflt->query($sql);
            $db_dflt->close();
            if ($query->num_rows() == 1) {
                return $query->row();
            }
        }
        return FALSE;
    }
    
    function is_id_kuesioner_exist($id_for_check) {
        if (!empty($id_for_check)) {
            $db_dflt = $this->load->database('default', TRUE);
            $sql = "SELECT mk.id_kuesioner "
                    . "FROM master_kuesioner mk "
                    . "WHERE mk.id_kuesioner = ".$id_for_check;
            $query = $db_dflt->query($sql);
            $db_dflt->close();
            if ($query->num_rows() == 1) {
                return TRUE;
            }
        }
        return FALSE;
    }

    function get_form($id_kuesioner) {
        $db_dflt = $this->load->database('default', TRUE);

        $sql = "SELECT * FROM (
            SELECT aa.id_pertanyaan, aa.id_kuesioner, aa.isi, aa.tipe, aa.id_kategori, aa.id_grup_pilihan, aa.id_grup_pilihan2, aa.jml_pilihan, aa.jml_pilihan2, IF(aa.order_no > 0, aa.order_no, 0) AS order_no FROM (
            SELECT mp.*, pp.jml_pilihan, pp2.jml_pilihan2,
            IF(mp.id_kategori <= 0,((SELECT MAX(tmp.id_kategori) FROM master_pertanyaan tmp)*10+3),(mp.id_kategori*10+2)) AS order_no
            FROM master_pertanyaan mp
            LEFT OUTER JOIN ( 
            SELECT p.id_grup_pilihan, count(*) AS jml_pilihan 
            FROM pilihan p 
            GROUP BY p.id_grup_pilihan 
            ) pp ON mp.id_grup_pilihan = pp.id_grup_pilihan
            LEFT OUTER JOIN ( 
            SELECT p2.id_grup_pilihan, count(*) AS jml_pilihan2 
            FROM pilihan p2 
            GROUP BY p2.id_grup_pilihan 
            ) pp2 ON mp.id_grup_pilihan2 = pp2.id_grup_pilihan 
            WHERE mp.id_kuesioner = ".$id_kuesioner.") aa
            UNION
            SELECT NULL, NULL, kp.nama, 'kategori', kp.id_kategori, NULL, NULL, NULL, NULL, IF(kp.id_kategori <= 0,((SELECT MAX(tmp2.id_kategori) FROM master_pertanyaan tmp2)*10+3),(kp.id_kategori*10+1)) AS order_no
            FROM master_pertanyaan mp
            JOIN kategori_pertanyaan kp ON mp.id_kategori = kp.id_kategori
            WHERE mp.id_kuesioner = ".$id_kuesioner."
            GROUP BY mp.id_kategori) aaa
            ORDER BY aaa.order_no ASC, aaa.id_pertanyaan";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->result();
        }
        return FALSE;
    }
    
    function get_array_jawaban_checker($id_kuesioner) {
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT mp.id_pertanyaan, mp.tipe
            FROM master_pertanyaan mp
            WHERE mp.id_kuesioner = ".$id_kuesioner."
            AND mp.is_mandatory = 1";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        $arr_checker = array();
        if ($query->num_rows() > 0) {
            foreach ($query->result() as $obj) {
                $arr_checker[$obj->id_pertanyaan] = $obj->tipe;
            }
        }
        return $arr_checker;
    }
    
    function insert_jawaban($id_periode,$id_kuesioner,$respondent_id,$arr_jawaban, $custom_data) {
        $db_dflt = $this->load->database('default', TRUE);
        $this->db->trans_start();
        
        foreach ($arr_jawaban as $key => $value) {
            $data_mysql = array(
                'id_periode' => $id_periode,
                'id_kuesioner' => $id_kuesioner,
                'id_pertanyaan' => $key,
                'respondent_id' => $respondent_id);
            if ($value->tipe == 'isian') {
                /*$col_jawaban = 'jawaban_isian';
                $jawaban = $value->jawaban;*/
                $data_mysql['jawaban_isian'] = $value->jawaban;
            } else {
                /*$col_jawaban = 'jawaban_pilihan';
                $jawaban = intval($value->jawaban);*/
                if (isset($value->jawaban)) {
                    $data_mysql['jawaban_pilihan'] = $value->jawaban;
                }
                if (isset($value->jawaban2)) {
                    $data_mysql['jawaban_pilihan2'] = $value->jawaban2;
                }
            }
            if ($custom_data != NULL) {
                $data_mysql['custom_data'] = $custom_data;
            }
            /*$data_mysql = array(
                'id_periode' => $id_periode,
                'id_kuesioner' => $id_kuesioner,
                'id_pertanyaan' => $key,
                'respondent_id' => $respondent_id,
                $col_jawaban => $jawaban,
            );*/
            //print_r($data_mysql);
            if ($data_mysql['jawaban_isian'] != '') {
                $this->db->insert('jawaban', $data_mysql);
            }
        }
        //exit();
        $this->db->trans_complete();
        $db_dflt->close();
    }
    
    function get_all_value_pilihan($id_pilihan) {
        if (!empty($id_pilihan)) {
            $db_dflt = $this->load->database('default', TRUE);
            $sql = "SELECT * FROM pilihan
                WHERE id_grup_pilihan = ".$id_pilihan." ORDER BY order_no";
            $query = $db_dflt->query($sql);
            $db_dflt->close();
            if ($query->num_rows() > 0) {
                return $query->result();
            }
        }
        return FALSE;
    }
}

?>
