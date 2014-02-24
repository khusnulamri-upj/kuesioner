<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Kuesioner extends CI_Controller {
    
    function __construct() {
        parent::__construct();
        $this->load->helper('session_helper');
        
    }
    
    public function index() {
        $this->lists();
    }
    
    public function lists() {
        $this->load->model('mKuesioner');
        $list_kuesioner = $this->mKuesioner->list_active_kuesioner();
        $index = 0;
        $html_kuesioner = '<table>';
        foreach($list_kuesioner as $obj) {
            if (!empty($obj->nama_kuesioner)) {
                $html_kuesioner .= '<tr>';
                $html_kuesioner .= '<td align="right">'.++$index.'</td><td><a href="'.site_url('kuesioner/start/'.url_safe_encode($this->encrypt->encode($obj->id_kuesioner))).'">'.$obj->nama_kuesioner.'</a></td>';
                $html_kuesioner .= '</tr>';
            }
        }
        $html_kuesioner .= '</table>';
        $data['html_form'] = $html_kuesioner;
        $this->load->view('kuesioner/list_kuesioner',$data);
    }
    
    public function start($enc_id_kuesioner = NULL) {
        $id_kuesioner = $this->encrypt->decode(url_safe_decode($enc_id_kuesioner));
        $this->load->model('mKuesioner');
        if ((empty($enc_id_kuesioner)) || (!$this->mKuesioner->is_id_kuesioner_exist($id_kuesioner))) {
            redirect(site_url('kuesioner/lists'));
        }
        $kuesioner_data = $this->mKuesioner->get_kuesioner_data($id_kuesioner);
        $str_respondent_id = $kuesioner_data->respondent_id;
        $respondent_id = $str_respondent_id();
        $enc_respondent_id = $this->encrypt->encode($respondent_id);
        $enc_str_respondent_id = $this->encrypt->encode('respondent_id');
        $html_hidden = '<input type="hidden" name="'.$enc_str_respondent_id.'" value="'.$enc_respondent_id.'">';
        
        $data['html_form'] = '<form method="POST" action="#">'.$html_hidden;
        
        $list_pertanyaan = $this->mKuesioner->get_form($id_kuesioner);
        $index = 0;
        $html_pertanyaan = '<table>';
        foreach($list_pertanyaan as $obj) {
            if (!empty($obj->isi)) {
                $html_pertanyaan .= '<tr>';
                $html_pertanyaan .= '<td align="right">'.++$index.'</td><td>'.$obj->isi.'</td>';
                if ($obj->tipe == 'pilihan') {
                    $html_radio = '';
                    $enc_id_pertanyaan = $this->encrypt->encode($obj->id_pertanyaan);
                    for ($i = 0; $i < $obj->jml_pilihan; $i++) {
                        $html_radio .= '<input type="radio" name="'.$enc_id_pertanyaan.'" value="'.$i.'">';
                    }
                    $html_pertanyaan .= '<td>'.$html_radio.'</td>';
                } else {
                    $html_pertanyaan .= '</tr><tr><td>&nbsp;</td><td><textarea name="'.$obj->id_pertanyaan.'"></textarea></td>';
                }
                $html_pertanyaan .= '</tr>';
            }
        }
        $html_pertanyaan .= '</table>';
        
        $data['html_form'] .= $html_pertanyaan.'</form>';
        
        $this->load->view('kuesioner/form_kuesioner',$data);
    }

}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */