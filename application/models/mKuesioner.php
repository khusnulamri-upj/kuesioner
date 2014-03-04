<?php

class MKuesioner extends CI_Model {

    function __construct() {
        // Call the Model constructor
        parent::__construct();
    }

    /*function list_active_kuesioner() {
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT p.id_periode, p.deskripsi, mk.id_kuesioner
            FROM periode p
            LEFT OUTER JOIN master_kuesioner mk ON mk.id_kuesioner = p.id_kuesioner
            WHERE p.waktu_min < NOW() AND p.waktu_maks > NOW()";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            //return $query->result();
            $a = $query->result();
            $a = array_merge($a,$query->result());
            //print_r($a);
            //exit();
            return $a;
        }
        return FALSE;
    }*/
    
    /*function list_active_kuesioner() {
        $arr_obj_return = array();
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT *
            FROM periode p
            LEFT OUTER JOIN master_kuesioner mk ON mk.id_kuesioner = p.id_kuesioner
            WHERE p.waktu_min < NOW() AND p.waktu_maks > NOW()";
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
                        $arr_obj_return[] = (object) array(
                            'id_periode' => $row->id_periode,
                            'id_kuesioner' => $row->id_kuesioner,
                            'deskripsi' => $deskripsi_return,
                            'custom_data' => $str_to_save,
                            'respondent_id' => $str_func()
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
                    $compare = TRUE;
                    foreach ($qry_delete->result() as $obj_del) {
                        if (($obj_del->id_periode == $obj_ori->id_periode) &&
                                ($obj_del->id_kuesioner == $obj_ori->id_kuesioner) &&
                                ($obj_del->respondent_id == $obj_ori->respondent_id) &&
                                ($obj_del->custom_data == $obj_ori->custom_data)) {
                            $compare = FALSE;
                        }
                    }
                    //print_r($compare);
                    if ($compare) {
                        $return[] = $obj_ori;
                    }
                }
            }
            //$a = $query->result();
            //$a = array_merge($a,$query->result());
            //print_r($a);
            //exit();
            return $return;
        }
        return FALSE;
    }*/
    
    function list_active_kuesioner() {
        $arr_obj_return = array();
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT *
            FROM periode p
            LEFT OUTER JOIN master_kuesioner mk ON mk.id_kuesioner = p.id_kuesioner
            WHERE p.waktu_min < NOW() AND p.waktu_maks > NOW()";
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
                        $arr_obj_return[] = (object) array(
                            'id_periode' => $row->id_periode,
                            'id_kuesioner' => $row->id_kuesioner,
                            'deskripsi' => $deskripsi_return,
                            'custom_data' => $str_to_save,
                            'respondent_id' => $str_func()
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
            $sql = "SELECT p.deskripsi, p.respondent_id
                FROM periode p
                LEFT OUTER JOIN master_kuesioner mk ON mk.id_kuesioner = p.id_kuesioner
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
            $this->db->insert('jawaban', $data_mysql);
        }
        //exit();
        $this->db->trans_complete();
        $db_dflt->close();
    }
}

?>
