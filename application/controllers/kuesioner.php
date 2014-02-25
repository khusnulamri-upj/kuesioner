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
            if (!empty($obj->deskripsi)) {
                $html_kuesioner .= '<tr>';
                $html_kuesioner .= '<td align="right">'.++$index.'</td><td><a href="'.site_url('kuesioner/start/'.url_safe_encode($this->encrypt->encode($obj->id_periode.'/'.$obj->id_kuesioner))).'">'.$obj->deskripsi.'</a></td>';
                $html_kuesioner .= '</tr>';
            }
        }
        $html_kuesioner .= '</table>';
        $data['html_form'] = $html_kuesioner;
        $this->load->view('kuesioner/list_kuesioner',$data);
    }
    
    public function start($enc_from_lists = NULL) {
        $dec_from_lists = $this->encrypt->decode(url_safe_decode($enc_from_lists));
        $arr_dec = explode('/', $dec_from_lists);
        $id_periode = $arr_dec[0];
        $id_kuesioner = $arr_dec[1];
        $this->load->model('mKuesioner');
        if ((empty($enc_from_lists)) || (!$this->mKuesioner->is_id_kuesioner_exist($id_kuesioner))) {
            redirect(site_url('kuesioner/lists'));
        }
        $kuesioner_data = $this->mKuesioner->get_kuesioner_data($id_kuesioner);
        $str_respondent_id = $kuesioner_data->respondent_id;
        $is_function = strpos($str_respondent_id, '()');

        if ($is_function === FALSE) {
            $respondent_id = $respondent_id;
        } else {
            $str_respondent_id = str_replace('()', '', $str_respondent_id);
            $respondent_id = $str_respondent_id();
        }
        
        $enc_id_periode = $this->encrypt->encode($id_periode);
        $enc_str_id_periode = $this->encrypt->encode('id_periode');
        $html_hidden = '<input type="hidden" name="'.$enc_str_id_periode.'" value="'.$enc_id_periode.'">';
        
        $enc_id_kuesioner = $this->encrypt->encode($id_kuesioner);
        $enc_str_id_kuesioner = $this->encrypt->encode('id_kuesioner');
        $html_hidden .= '<input type="hidden" name="'.$enc_str_id_kuesioner.'" value="'.$enc_id_kuesioner.'">';
        
        $enc_respondent_id = $this->encrypt->encode($respondent_id);
        $enc_str_respondent_id = $this->encrypt->encode('respondent_id');
        $html_hidden .= '<input type="hidden" name="'.$enc_str_respondent_id.'" value="'.$enc_respondent_id.'">';
        
        $data['html_form'] = '<form method="POST" action="'.site_url('kuesioner/finish').'">'.$html_hidden;
        
        $list_pertanyaan = $this->mKuesioner->get_form($id_kuesioner);
        $index = 0;
        $html_pertanyaan = '<table>';
        foreach($list_pertanyaan as $obj) {
            if (!empty($obj->isi)) {
                $html_pertanyaan .= '<tr>';
                $html_pertanyaan .= '<td align="right">'.++$index.'</td><td>'.$obj->isi.'</td>';
                $enc_id_pertanyaan = $this->encrypt->encode('tanya'.$obj->id_pertanyaan.'tanya'.$obj->tipe);
                if ($obj->tipe == 'pilihan') {
                    $html_radio = '';
                    for ($i = 1; $i <= $obj->jml_pilihan; $i++) {
                        $html_radio .= '<input type="radio" name="'.$enc_id_pertanyaan.'" value="'.$i.'">';
                    }
                    $html_pertanyaan .= '<td>'.$html_radio.'</td>';
                } else {
                    $html_pertanyaan .= '</tr><tr><td>&nbsp;</td><td><textarea name="'.$enc_id_pertanyaan.'"></textarea></td>';
                }
                $html_pertanyaan .= '</tr>';
            }
        }
        $html_pertanyaan .= '</table>';
        
        $data['html_form'] .= $html_pertanyaan.'<input type="submit" value="Simpan"></form>';
        
        $this->load->view('kuesioner/form_kuesioner',$data);
    }
    
    public function finish() {
        $arr_jawaban = array();
        $id_periode = NULL;
        $id_kuesioner = NULL;
        $respondent_id = NULL;
        foreach ($this->input->post() as $key => $value) {
            $index = $this->encrypt->decode($key);
            $is_id_periode = strpos($index, 'id_periode');
            $is_id_kuesioner = strpos($index, 'id_kuesioner');
            $is_respondent_id = strpos($index, 'respondent_id');
            $is_pertanyaan = strpos($index, 'tanya');
            if ($is_id_periode !== FALSE) {
                $id_periode = $this->encrypt->decode($value);
            }
            if ($is_id_kuesioner !== FALSE) {
                $id_kuesioner = $this->encrypt->decode($value);
            }
            if ($is_respondent_id !== FALSE) {
                $respondent_id = $this->encrypt->decode($value);
            }
            if ($is_pertanyaan !== FALSE) {
                $no = explode('tanya',$index);
                $arr_jawaban[$no[1]] = new stdClass;
                $arr_jawaban[$no[1]]->jawaban = $value;
                $arr_jawaban[$no[1]]->tipe = $no[2];
            }
        }
        $this->load->model('mKuesioner');
        $this->mKuesioner->insert_jawaban($id_periode,$id_kuesioner,$respondent_id,$arr_jawaban);
        print_r($id_periode);
        print_r($id_kuesioner);
        print_r($respondent_id);
        print_r($arr_jawaban);
    }
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */