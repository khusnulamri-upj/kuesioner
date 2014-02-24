<?php

class MKuesioner extends CI_Model {

    function __construct() {
        // Call the Model constructor
        parent::__construct();
    }

    function list_active_kuesioner() {
        $db_dflt = $this->load->database('default', TRUE);
        $sql = "SELECT mk.id_kuesioner, mk.nama_kuesioner "
                . "FROM master_kuesioner mk "
                . "WHERE mk.active = 1";
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->result();
        }
        return FALSE;
    }
    
    function get_kuesioner_data($id_for_search) {
        if (!empty($id_for_search)) {
            $db_dflt = $this->load->database('default', TRUE);
            $sql = "SELECT mk.id_kuesioner, mk.nama_kuesioner, mk.respondent_id "
                    . "FROM master_kuesioner mk "
                    . "WHERE mk.id_kuesioner = ".$id_for_search;
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

        $sql = "SELECT * "
                . "FROM master_kuesioner mk "
                . "LEFT OUTER JOIN master_pertanyaan mp ON mk.id_kuesioner = mp.id_kuesioner "
                . "LEFT OUTER JOIN ( "
                . "SELECT p.id_grup_pilihan, count(*) AS jml_pilihan "
                . "FROM pilihan p "
                . "GROUP BY p.id_grup_pilihan "
                . ") pp ON mp.id_grup_pilihan = pp.id_grup_pilihan "
                . "WHERE mk.active = 1 "
                . "AND mk.id_kuesioner = ".$id_kuesioner;
        $query = $db_dflt->query($sql);
        $db_dflt->close();
        if ($query->num_rows() > 0) {
            return $query->result();
        }
        return FALSE;
    }

}

?>
