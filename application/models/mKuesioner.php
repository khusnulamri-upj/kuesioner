<?php

class MKuesioner extends CI_Model {

    function __construct() {
        // Call the Model constructor
        parent::__construct();
    }
    
    function list_active_kuesioner() {
        $arr_obj_return = array();
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT *
            FROM periode p
            LEFT OUTER JOIN master_kuesioner mk ON mk.id_kuesioner = p.id_kuesioner
            WHERE p.waktu_min <= NOW() AND p.waktu_maks >= NOW()";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            //return $query->result();
            //print_r($query->result());
            //exit();
            foreach ($query->result() as $row) {
                //CREATE ALL LIST KUESIONER AVAIBLE FOR THIS RESPONDENT_ID
                if ((strpos($row->respondent_id,'()') === FALSE) || (strpos($row->generator_config,'db=') === FALSE) || (strpos($row->generator_config,'sql=') === FALSE)) {
                    exit('#Check your periode config.');
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
                        $arr_field_save = explode($row->separator, $str_to_save);
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
                        $arr_field_throw = explode($row->separator, $str_to_throw);
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
                            'throwed_data' => $str_to_throw,
                            'separator' => $row->separator
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
    
    function get_periode_data($id_periode = NULL) {
        if ($id_periode == NULL) {
            return FALSE;
        }
        $db_dflt = $this->load->database('default', TRUE);
        /*$sql = "SELECT *
            FROM periode p
            LEFT OUTER JOIN master_kuesioner mk ON mk.id_kuesioner = p.id_kuesioner
            WHERE p.waktu_min <= NOW() AND p.waktu_maks >= NOW() AND mk.shortname = 'EDOM'";*/
        $sql = "SELECT *
            FROM periode p
            WHERE id_periode = ".$id_periode."
            LIMIT 1";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->row();
        } else {
            return FALSE;
        }
    }
    
    function edom_list_active_kuesioner() {
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT *
            FROM periode p
            LEFT OUTER JOIN master_kuesioner mk ON mk.id_kuesioner = p.id_kuesioner
            WHERE p.waktu_min <= NOW() AND p.waktu_maks >= NOW() AND mk.shortname = 'EDOM'";
        /*$sql = "SELECT *
            FROM periode p
            LEFT OUTER JOIN master_kuesioner mk ON mk.id_kuesioner = p.id_kuesioner
            WHERE p.waktu_min <= NOW() AND p.waktu_maks >= NOW()";*/
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        $return = array();
        if ($query->num_rows() > 0) {
            foreach ($query->result() as $row) {
                $arr_obj_return = array();
                //CREATE ALL LIST KUESIONER AVAIBLE FOR THIS RESPONDENT_ID
                if ((strpos($row->respondent_id,'()') === FALSE) || (strpos($row->generator_config,'db=') === FALSE) || (strpos($row->generator_config,'sql=') === FALSE) || (empty($row->separator))) {
                    exit('#Check your periode config.');
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
                        $deskripsi_return = $row->deskripsi;
                        //deskripsi
                        $arr_prop_tmp = get_object_vars($row_tmp);
                        foreach($arr_prop_tmp as $key => $value) {
                            if (strpos($deskripsi_return,'{'.$key.'}') !== FALSE) {
                                $deskripsi_return = str_replace('{'.$key.'}', $row_tmp->$key, $deskripsi_return);
                            }
                        }
                        //membuat string data yang akan disimpan dalam database
                        $str_to_save = $row->custom_data_format;
                        $arr_field_save = explode($row->separator, $str_to_save);
                        //replace string data to save
                        if (sizeof($arr_field_save) > 0) {
                            foreach($arr_field_save as $value) {
                                if ((strpos($value,'{') !== FALSE) && (strpos($value,'}') !== FALSE)) {
                                    if (strpos($value, $this->config->item('kuesioner_ftisfc')) !== FALSE) {
                                        $field_save = str_replace('}', '', str_replace('{', '', $value));
                                        $str_to_save = str_replace($value, $row_tmp->$field_save, $str_to_save);
                                        //$deskripsi_return = str_replace($value, $row_tmp->$field_save, $deskripsi_return);
                                    }
                                }
                            }
                        } else {
                            exit('#Check your periode config.');
                        }
                        //string save kedua
                        $str_to_save2 = $row->custom_data2_format;
                        $arr_field_save2 = explode($row->separator, $str_to_save2);
                        if (sizeof($arr_field_save2) > 0) {
                            foreach($arr_field_save2 as $value) {
                                if ((strpos($value,'{') !== FALSE) && (strpos($value,'}') !== FALSE)) {
                                    if (strpos($value, $this->config->item('kuesioner_ftisfc')) == FALSE) {
                                        $field_save2 = str_replace('}', '', str_replace('{', '', $value));
                                        $str_to_save2 = str_replace($value, $row_tmp->$field_save2, $str_to_save2);
                                        //$deskripsi_return = str_replace($value, $row_tmp->$field_save2, $deskripsi_return);
                                    }
                                }
                            }
                        }
                        //membuat string data yang akan digunakan dalam coding
                        $str_to_throw = $row->data_helper;
                        $arr_field_throw = explode($row->separator, $str_to_throw);
                        if (sizeof($arr_field_throw) > 0) {
                            foreach($arr_field_throw as $value) {
                                if ((strpos($value,'{') !== FALSE) && (strpos($value,'}') !== FALSE)) {
                                    $field_throw = str_replace('}', '', str_replace('{', '', $value));
                                    $str_to_throw = str_replace($value, $field_throw.'='.$row_tmp->$field_throw, $str_to_throw);
                                }
                            }
                        }
                        $arr_obj_return[] = (object) array(
                            'id_periode' => $row->id_periode,
                            'id_kuesioner' => $row->id_kuesioner,
                            'deskripsi' => $deskripsi_return,
                            'custom_data' => $str_to_save,
                            'custom_data2' => $str_to_save2,
                            'respondent_id' => $str_func(),
                            'throwed_data' => $str_to_throw,
                            'separator' => $row->separator
                        );
                    }
                }
                //DELETE KUESIONER THAT HAS BEEN FILLED (MARK that KUESIONER HAS BEEN FILLED)
                $db_delete = $this->load->database('default', TRUE);
                /*$sql_delete = "SELECT j.id_periode, j.id_kuesioner, j.respondent_id, j.custom_data
                    FROM jawaban j
                    GROUP BY j.id_periode, j.id_kuesioner, j.respondent_id, j.custom_data";*/
                
                //USING JAWABAN_HEADER
                /*$sql_delete = "SELECT jh.id_periode, jh.id_kuesioner, jh.respondent_id, jh.custom_data, jh.custom_data2
                    FROM jawaban_header jh
                    GROUP BY jh.id_periode, jh.id_kuesioner, jh.respondent_id, jh.custom_data, jh.custom_data2";*/
                $sql_delete = "SELECT jh.id_periode, jh.id_kuesioner, jh.respondent_id, jh.custom_data, jh.custom_data2
                    FROM ".$row->tabel_jawaban_header." jh
                    GROUP BY jh.id_periode, jh.id_kuesioner, jh.respondent_id, jh.custom_data, jh.custom_data2";
                
                $qry_delete = $db_delete->query($sql_delete);
                $db_delete->close();
                foreach ($arr_obj_return as $obj_ori) {
                    //print_r($obj_ori);
                    //print_r('<br/>');
                    $obj_ori->is_filled = TRUE;
                    $is_diff = TRUE;
                    foreach ($qry_delete->result() as $obj_del) {
                        //print_r('<br/>--<br/>');
                        //print_r($obj_del);
                        if (($obj_del->id_periode == $obj_ori->id_periode) &&
                                ($obj_del->id_kuesioner == $obj_ori->id_kuesioner) &&
                                ($obj_del->respondent_id == $obj_ori->respondent_id) &&
                                ($obj_del->custom_data == $obj_ori->custom_data) &&
                                ($obj_del->custom_data2 == $obj_ori->custom_data2)) {
                            $is_diff = FALSE;
                            //print_r('<br/>--OK--<br/>');
                        }
                    }
                    //print_r($is_diff);
                    if ($is_diff) {
                        $obj_ori->is_filled = FALSE;
                        //print_r('<br/>--NOT FILLED--<br/>');
                    }
                    //print_r('<br/>return<<--<br/>');
                    //print_r($return);
                    $return[] = $obj_ori;
                }
            }
            //$a = $query->result();
            //$a = array_merge($a,$query->result());
            //print_r($a);
            //exit();
            //print_r('<br/><<----------<<<br/>');
            //print_r($return);
            //exit();
            return $return;
        }
        return FALSE;
    }
    
    function get_kuesioner_data($id_for_search, $id_periode_for_search) {
        if (!empty($id_for_search)) {
            $db_dflt = $this->load->database('default', TRUE);
            $sql = "SELECT p.deskripsi, p.respondent_id, p.separator, mk.custom_header, p.custom_data_format, MAX(pp.jml_pilihan) AS jml_pilihan, MAX(pp2.jml_pilihan2) AS jml_pilihan2, mk.config_kuesioner,
                p.data_helper AS throwed_data_format, p.custom_data2_format
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
    
    function get_next_respon_ke($respondent_id, $custom_data) {
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT IF(MAX(respon_ke) IS NULL,0,MAX(respon_ke))+1 AS next_respon_ke "
                . "FROM jawaban "
                . "WHERE custom_data = '".$custom_data."' "
                . "AND respondent_id = '".$respondent_id."'";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() == 1) {
            $obj = $query->row();
            return $obj->next_respon_ke;
        }
        return 1;
    }
    
    function insert_jawaban($id_periode,$id_kuesioner,$respondent_id,$arr_jawaban, $custom_data, $custom_data2) {
        $obj_periode = $this->get_periode_data($id_periode);
        
        $db_dflt = $this->load->database('default', TRUE);
        $db_dflt->trans_start();
        
        //USING JAWABAN_HEADER
        $data_header = array(
            'id_periode' => $id_periode,
            'id_kuesioner' => $id_kuesioner,
            'respondent_id' => $respondent_id,
            'respon_ke' => $this->get_next_respon_ke($respondent_id, $custom_data));
        if ($custom_data != NULL) {
            $data_header['custom_data'] = $custom_data;
        }
        if ($custom_data2 != NULL) {
            $data_header['custom_data2'] = $custom_data2;
        }
        //$db_dflt->insert('jawaban_header', $data_header);
        $db_dflt->insert($obj_periode->tabel_jawaban_header, $data_header);
        
        foreach ($arr_jawaban as $key => $value) {
            $is_isian_kosong = FALSE;
            $data_mysql = array(
                'id_periode' => $id_periode,
                'id_kuesioner' => $id_kuesioner,
                'id_pertanyaan' => $key,
                'respondent_id' => $respondent_id);
            if ($value->tipe == 'isian') {
                /*$col_jawaban = 'jawaban_isian';
                $jawaban = $value->jawaban;*/
                $data_mysql['jawaban_isian'] = $value->jawaban;
                if ($value->jawaban == '') {
                    $is_isian_kosong = TRUE;
                }
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
            if ($custom_data2 != NULL) {
                $data_mysql['custom_data2'] = $custom_data2;
            }
            /*$data_mysql = array(
                'id_periode' => $id_periode,
                'id_kuesioner' => $id_kuesioner,
                'id_pertanyaan' => $key,
                'respondent_id' => $respondent_id,
                $col_jawaban => $jawaban,
            );*/
            //print_r($data_mysql);
            $data_mysql['respon_ke'] = $data_header['respon_ke'];
            if (!$is_isian_kosong) {
                //$db_dflt->insert('jawaban', $data_mysql);
                $db_dflt->insert($obj_periode->tabel_jawaban, $data_mysql);
            }
        }
        //exit();
        $db_dflt->trans_complete();
        $db_dflt->close();
    }
    
    //USING JAWABAN_HEADER
    function sync_jawaban_to_jawaban_header($id_periode = NULL) {
        if ($id_periode == NULL) {
            return '0';
        }
        
        $obj_periode = $this->get_periode_data($id_periode);
        
        if ($obj_periode == FALSE) {
            return '0';
        }
        
        $db_dflt = $this->load->database('default', TRUE);
        $db_dflt->trans_start();
        
        /*$sql = "INSERT INTO ".$obj_periode->tabel_jawaban_header."
            SELECT NULL, NULL, bb.id_periode, bb.id_kuesioner, bb.respondent_id, bb.respon_ke, bb.custom_data, bb.custom_data2 FROM (
            SELECT aa.id_periode, aa.id_kuesioner, aa.respondent_id, aa.respon_ke, aa.custom_data, aa.custom_data2, SUM(flag) AS jumlah FROM (
            SELECT jh.id_periode, jh.id_kuesioner, jh.respondent_id, jh.respon_ke, jh.custom_data, jh.custom_data2, 1 AS flag
            FROM ".$obj_periode->tabel_jawaban_header." jh
            UNION
            SELECT j.id_periode, j.id_kuesioner, j.respondent_id, j.respon_ke, j.custom_data, j.custom_data2, 2 AS flag
            FROM ".$obj_periode->tabel_jawaban." j
            ) aa
            GROUP BY aa.id_periode, aa.id_kuesioner, aa.respondent_id, aa.respon_ke, aa.custom_data, aa.custom_data2
            ) bb
            WHERE bb.jumlah = 2";*/
        
        $sql = "INSERT INTO ".$obj_periode->tabel_jawaban_header."
            SELECT NULL, NULL, bb.id_periode, bb.id_kuesioner, bb.respondent_id, bb.respon_ke, bb.custom_data, bb.custom_data2 FROM (
            SELECT aa.id_periode, aa.id_kuesioner, aa.respondent_id, aa.respon_ke, aa.custom_data, aa.custom_data2, SUM(flag) AS jumlah FROM (
            SELECT jh.id_periode, jh.id_kuesioner, jh.respondent_id, jh.respon_ke, jh.custom_data, jh.custom_data2, 1 AS flag
            FROM ".$obj_periode->tabel_jawaban_header." jh
            WHERE jh.id_periode = ".$obj_periode->id_periode."
            UNION
            SELECT j.id_periode, j.id_kuesioner, j.respondent_id, j.respon_ke, j.custom_data, j.custom_data2, 2 AS flag
            FROM ".$obj_periode->tabel_jawaban." j
            WHERE j.id_periode = ".$obj_periode->id_periode."
            ) aa
            GROUP BY aa.id_periode, aa.id_kuesioner, aa.respondent_id, aa.respon_ke, aa.custom_data, aa.custom_data2
            ) bb
            WHERE bb.jumlah = 2";
        
        $query = $db_dflt->query($sql);
        
        $affected_rows = $db_dflt->affected_rows();
        //exit($affected_rows.'-test');
        
        $db_dflt->trans_complete();
        $db_dflt->close();
        
        return '+'.$affected_rows;
    }
}

?>
