<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Kuesioner extends CI_Controller {
    
    function __construct() {
        parent::__construct();
        $this->load->helper('session_helper');
    }
    
    public function index() {
        $this->edom_lists();
    }
    
    /*public function lists() {
        $this->load->model('mKuesioner');
        $list_kuesioner = $this->mKuesioner->list_active_kuesioner();
        //print_r($list_kuesioner);
        if (empty($list_kuesioner)) {
            exit();
            //redirect($this->config->item('kuesioner_app_base'));
        }
        $index = 0;
        $html_kuesioner = '<table>';
        foreach($list_kuesioner as $obj) {
            if (!empty($obj->deskripsi)) {
                $html_kuesioner .= '<tr>';
                //$html_kuesioner .= '<td align="right">'.++$index.'</td><td><a href="'.site_url('kuesioner/start/'.url_safe_encode($this->encrypt->encode($obj->id_periode.'/'.$obj->id_kuesioner.'/'.$obj->custom_data))).'">'.$obj->deskripsi.'</a></td>';
                $html_kuesioner .= '<td><a class="width-set1 button" href="'.site_url('kuesioner/start/'.url_safe_encode($this->encrypt->encode($obj->id_periode.'/'.$obj->id_kuesioner.'/'.$obj->custom_data))).'">'.$obj->deskripsi.'</a></td>';
                $html_kuesioner .= '</tr>';
            }
        }
        $html_kuesioner .= '</table>';
        $data['html_form'] = $html_kuesioner;
        $this->load->view('kuesioner/list_kuesioner',$data);
    }*/
    
    public function edom_lists() {
        $this->load->model('mKuesioner');
        $list_kuesioner = $this->mKuesioner->edom_list_active_kuesioner();
        //print_r($list_kuesioner);
        if (empty($list_kuesioner)) {
            exit();
            //redirect($this->config->item('kuesioner_app_base'));
        }
        $index = 1;
        $html_kuesioner = '<table class="bordered">';
        $val_row_before = '';
        $val_row_before2 = '';
        $count_list_kuesioner = count($list_kuesioner);
        $i = 0;
        foreach($list_kuesioner as $obj) {
            $i++;
            if (!empty($obj->deskripsi)) {
                //$html_kuesioner .= '<td align="right">'.++$index.'</td><td><a href="'.site_url('kuesioner/start/'.url_safe_encode($this->encrypt->encode($obj->id_periode.'/'.$obj->id_kuesioner.'/'.$obj->custom_data))).'">'.$obj->deskripsi.'</a></td>';
                $enable_kuesioner = 'class="disabled-button boxed" href="#"';
                $btn_enabled = FALSE;
                if ($obj->is_filled == FALSE) {
                     $enable_kuesioner = 'class="button boxed" href="'.site_url('kuesioner/start/'.url_safe_encode($this->encrypt->encode($obj->id_periode.'/'.$obj->id_kuesioner.'/'.$obj->custom_data))).'"';
                     $btn_enabled = TRUE;
                }
                $deskripsi = $obj->deskripsi;
                $no = $index++;
                $btn_text = 'Isi Kuesioner';
                $style1 = '';
                //AMRNOTE: untuk men-disable kuesioner ke-2 dengan dosen dan mk yang sama
                $session2_begin = TRUE;
                if (!empty($obj->throwed_data)) {
                //print_r(strlen($obj->throwed_data).'-');
                //if (strlen($obj->throwed_data) > 0) {
                    $str_throwed_data = $obj->throwed_data;
                    $arr_throwed_data = explode(';', $str_throwed_data);
                    foreach($arr_throwed_data as $val) {
                        $arr_throwed_data2 = explode('=', $val);
                        $$arr_throwed_data2[0] = $arr_throwed_data2[1];
                    }
                    if (($is_same == 1) && ($val_row_before == $obj->is_filled)) {
                        $enable_kuesioner = 'class="disabled-button boxed" href="#"';
                        $btn_enabled = FALSE;
                    }
                    if ($val_row_before2 == $obj->deskripsi) {
                        $deskripsi = '</td><td>';
                    }
                    $arr_tmp_before = explode('</td><td>',$val_row_before2);
                    $mata_kuliah_before = $arr_tmp_before[0];
                    if (empty($mata_kuliah_before)) {
                        $mata_kuliah_before = FALSE;
                    }
                    $arr_tmp = explode('</td><td>',$obj->deskripsi);
                    $mata_kuliah = $arr_tmp[0];
                    $style1 = ' class="yes-top-border"';
                    if ($mata_kuliah_before == $mata_kuliah) {
                        $no = '';
                        $index--;
                        $deskripsi = str_replace($mata_kuliah, '', $deskripsi);
                        if (($btn_enabled == TRUE) && ($session2_begin == FALSE) && ($is_same == 1)) {
                            $enable_kuesioner = 'class="disabled-button boxed" href="#"';
                        }
                        $style1 = '';
                    }
                    if ($i == $count_list_kuesioner) {
                        $style1 = ' class="yes-bottom-border"';
                    }
                    //nilai dosen di row sebelumnya
                    $val_row_before = $obj->is_filled;
                    $val_row_before2 = $obj->deskripsi;
                }
                $html_kuesioner .= '<tr'.$style1.'>';
                //$html_kuesioner .= '<td>'.$no.'</td><td>'.$deskripsi.'</td><td><a '.$enable_kuesioner.'>'.$btn_text.'</a></td>';
                $html_kuesioner .= '<td class="width-set2">'.$no.'</td><td>'.$deskripsi.'</td><td><a '.$enable_kuesioner.'>'.$btn_text.'</a></td>';
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
        $kuesioner_data = $this->mKuesioner->get_kuesioner_data($id_kuesioner,$id_periode);
        //print_r($kuesioner_data);
        $str_respondent_id = $kuesioner_data->respondent_id;
        $is_function = strpos($str_respondent_id, '()');
        if ($is_function === FALSE) {
            $respondent_id = $str_respondent_id;
        } else {
            $str_respondent_id = str_replace('()', '', $str_respondent_id);
            $respondent_id = $str_respondent_id();
        }
        if ((empty($enc_from_lists)) || (empty($id_periode)) || (!$this->mKuesioner->is_id_kuesioner_exist($id_kuesioner)) || (empty($respondent_id))) {
            redirect(site_url('kuesioner/lists'));
        }
        
        $html_hidden = '';
        if (array_key_exists(2, $arr_dec)) {
            if (!empty($arr_dec[2])) {
                $custom_data = $arr_dec[2];
                //VARIABLE CUSTOM FOR SAVING TO DATABASE
                $enc_custom_data = $this->encrypt->encode($custom_data);
                $enc_str_custom_data = $this->encrypt->encode('custom_data');
                $html_hidden .= '<input type="hidden" name="'.$enc_str_custom_data.'" value="'.$enc_custom_data.'">';
                //$html_hidden .= '<input type="hidden" name="custom_data" value="'.$custom_data.'">';
            }
        }
        //VARIABLE REQUIRED FOR SAVING TO DATABASE
        $enc_id_periode = $this->encrypt->encode($id_periode);
        $enc_str_id_periode = $this->encrypt->encode('id_periode');
        $html_hidden .= '<input type="hidden" name="'.$enc_str_id_periode.'" value="'.$enc_id_periode.'">';
        $enc_id_kuesioner = $this->encrypt->encode($id_kuesioner);
        $enc_str_id_kuesioner = $this->encrypt->encode('id_kuesioner');
        $html_hidden .= '<input type="hidden" name="'.$enc_str_id_kuesioner.'" value="'.$enc_id_kuesioner.'">';
        $enc_respondent_id = $this->encrypt->encode($respondent_id);
        $enc_str_respondent_id = $this->encrypt->encode('respondent_id');
        $html_hidden .= '<input type="hidden" name="'.$enc_str_respondent_id.'" value="'.$enc_respondent_id.'">';
        
        $data['html_form'] = '<form method="POST" action="'.site_url('kuesioner/finish').'">'.$html_hidden;
        
        if ((!empty($kuesioner_data->custom_header)) && (!empty($custom_data))) {
            $str_header = $kuesioner_data->custom_header;
            $arr_for_index = explode(';', $kuesioner_data->custom_data_format);
            $arr_for_value = explode(';', $custom_data);
            $ii = 0;
            foreach ($arr_for_index as $for_index) {
                $str_header = str_replace($for_index, $arr_for_value[$ii++], $str_header);
            }
            //print_r($arr_for_replace_header);
            $data['html_form'] .= $str_header;
            if (strpos($str_header, '<!--</table>-->') === FALSE) {
                $html_pertanyaan = '<table class="bordered">';
            } else {
                $html_pertanyaan = '';
            }
        }
        
        $list_pertanyaan = $this->mKuesioner->get_form($id_kuesioner);
        $index = 0;
        $for_colspan = 1;
        foreach($list_pertanyaan as $obj) {
            if (!empty($obj->tipe)) {
                if (!empty($kuesioner_data->jml_pilihan2)) {
                    $for_colspan = $kuesioner_data->jml_pilihan2+$kuesioner_data->jml_pilihan+1+1;
                } else if (!empty($kuesioner_data->jml_pilihan)) {
                    $for_colspan = $kuesioner_data->jml_pilihan+1;
                }
                $html_pertanyaan .= '<tr>';
                if ($obj->tipe == 'kategori') {
                    $html_pertanyaan .= '<td class="width-set2">&nbsp;</td><td colspan="'.$for_colspan.'"><b>'.$obj->isi.'</b></td>';
                } else if ($obj->tipe == 'isian') {
                    $html_pertanyaan .= '<td class="width-set2">'.++$index.'</td><td>'.$obj->isi.'</td><td colspan="'.$for_colspan.'"></td>';
                } else {
                    $html_pertanyaan .= '<td class="width-set2">'.++$index.'</td><td>'.$obj->isi.'</td>';
                }
                if ($obj->tipe == 'pilihan') {
                    $enc_id_pertanyaan = $this->encrypt->encode('pilihantanya'.$obj->id_pertanyaan.'tanya'.$obj->tipe);
                    $html_radio = '';
                    //AMRNEEDTOIMPROVE : value=$i ??
                    for ($i = 1; $i <= $obj->jml_pilihan; $i++) {
                        $html_radio .= '<td><input type="radio" name="'.$enc_id_pertanyaan.'" value="'.$i.'"></td>';
                    }
                    if (!empty($obj->jml_pilihan2)) {
                        $enc_id_pertanyaan = $this->encrypt->encode('pilihan2tanya'.$obj->id_pertanyaan.'tanya'.$obj->tipe);
                        //$html_radio .= '</td><td>&nbsp;</td><td>';
                        $html_radio .= '<td></td>';
                        for ($i = 1; $i <= $obj->jml_pilihan2; $i++) {
                            $html_radio .= '<td><input type="radio" name="'.$enc_id_pertanyaan.'" value="'.$i.'"></td>';
                        }
                    }
                    //$html_pertanyaan .= '<td>'.$html_radio.'</td>';
                    $html_pertanyaan .= $html_radio;
                } else if ($obj->tipe == 'isian') {
                    $enc_id_pertanyaan = $this->encrypt->encode('tanya'.$obj->id_pertanyaan.'tanya'.$obj->tipe);
                    $html_pertanyaan .= '</tr><tr><td></td><td><textarea class="width-set3" name="'.$enc_id_pertanyaan.'"></textarea></td><td colspan="'.$for_colspan.'"></td>';
                }
                $html_pertanyaan .= '</tr>';
            }
        }
        $html_pertanyaan .= '</table>';
        $data['html_form'] .= $html_pertanyaan.'<div class="centered"><input class="button padding-line" type="submit" value="Simpan"></div></form>';
        $this->load->view('kuesioner/form_kuesioner',$data);
    }
    
    public function finish() {
        $arr_jawaban = array();
        $id_periode = NULL;
        $id_kuesioner = NULL;
        $respondent_id = NULL;
        //print_r($this->input->post());
        foreach ($this->input->post() as $key => $value) {
            $index = $this->encrypt->decode($key);
            $is_id_periode = strpos($index, 'id_periode');
            $is_id_kuesioner = strpos($index, 'id_kuesioner');
            $is_respondent_id = strpos($index, 'respondent_id');
            $is_pertanyaan = strpos($index, 'tanya');
            $is_custom_data = strpos($index, 'custom_data');
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
                if (!array_key_exists($no[1], $arr_jawaban)) {
                    $arr_jawaban[$no[1]] = new stdClass;
                }
                if ($no[0] === 'pilihan2') {
                    $arr_jawaban[$no[1]]->jawaban2 = $value;
                } else {
                    $arr_jawaban[$no[1]]->jawaban = $value;
                }
                $arr_jawaban[$no[1]]->tipe = $no[2];
            }
            if ($is_custom_data !== FALSE) {
                $custom_data = $this->encrypt->decode($value);
            }
            //print_r($custom_data);
            //print_r($index);
        }
        //print_r($custom_data);
        $this->load->model('mKuesioner');
        $this->mKuesioner->insert_jawaban($id_periode,$id_kuesioner,$respondent_id,$arr_jawaban,$custom_data);
        //print_r($id_periode);
        //print_r($id_kuesioner);
        //print_r($respondent_id);
        //print_r($arr_jawaban);
        
        redirect(site_url('/kuesioner'));
    }
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */