<?php

class MKuesioner extends CI_Model {

    function __construct() {
        // Call the Model constructor
        parent::__construct();
    }

    function list_active_kuesioner() {
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
    }
    
    function get_kuesioner_data($id_for_search) {
        if (!empty($id_for_search)) {
            $db_dflt = $this->load->database('default', TRUE);
            $sql = "SELECT p.deskripsi, p.respondent_id
                FROM periode p
                LEFT OUTER JOIN master_kuesioner mk ON mk.id_kuesioner = p.id_kuesioner
                WHERE mk.id_kuesioner = ".$id_for_search;
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
    
    function insert_jawaban($id_periode,$id_kuesioner,$respondent_id,$arr_jawaban) {
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
            /*$data_mysql = array(
                'id_periode' => $id_periode,
                'id_kuesioner' => $id_kuesioner,
                'id_pertanyaan' => $key,
                'respondent_id' => $respondent_id,
                $col_jawaban => $jawaban,
            );*/
            $this->db->insert('jawaban', $data_mysql);
        }
        
        $this->db->trans_complete();
        $db_dflt->close();
    }
}

?>
