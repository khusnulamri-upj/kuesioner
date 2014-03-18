<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Laporan extends CI_Controller {
    
    function __construct() {
        parent::__construct();
        $this->load->helper('session_helper');
    }
    
    public function index() {
        $this->session->sess_destroy();
    }
    
    //per dosen per mata kuliah
    public function edom_1() {
        if ($this->input->post('submit') == 'Lihat') {
            $newdata = array(
                'edom_1_tahun' => $this->input->post('edom_1_tahun'),
                'edom_1_dosen' => $this->input->post('edom_1_dosen'),
                'edom_1_mk' => $this->input->post('edom_1_mk')
            );
            $this->session->set_userdata($newdata);
            //print_r($this->session->userdata('tahun'));
            redirect(current_url(), 'location');
        }
        print_r($this->session->all_userdata());
        $this->load->model('mLaporan');
        $list_tahun = $this->mLaporan->edom_get_tahun();
        $data['html'] = '<form method="POST" action="'.site_url('laporan/edom_1').'">';
        $data['html'] .= '<table><tr>';
        $data['html'] .= '<td>Tahun : </td><td><select name="edom_1_tahun[]" multiple="multiple">';
        foreach ($list_tahun as $obj) {
            $selected = '';
            $sess_tahun = $this->session->userdata('edom_1_tahun');
            if (is_array($sess_tahun)) {
                if (in_array($obj->tahun, $sess_tahun) ) {
                    $selected = ' selected="selected"';
                }
            }
            $data['html'] .= '<option value="'.$obj->tahun.'"'.$selected.'>'.$obj->deskripsi.'</option>';
        }
        $data['html'] .= '</select></td>';
        
        $select_dosen = '<td>Dosen : </td><td><select name="edom_1_dosen">';
        $list_dosen = $this->mLaporan->edom_get_dosen_by_tahun($this->session->userdata('edom_1_tahun'));
        if ($list_dosen != FALSE) {
            foreach ($list_dosen as $obj) {
                $selected = '';
                $sess_dosen = $this->session->userdata('edom_1_dosen');
                if (isset($sess_dosen)) {
                    if ($obj->DosenID === $sess_dosen) {
                        $selected = ' selected="selected"';
                    }
                }
                $select_dosen .= '<option value="'.$obj->DosenID.'"'.$selected.'>'.$obj->Nama_Dosen.'</option>';
            }
        } else {
            $select_dosen = '<td>Dosen : </td><td><select name="edom_1_dosen" disabled="disabled">';
            $select_dosen .= '<option selected="selected">Tidak Ada Data Dosen</option>';
        }
        $select_dosen .= '</select></td>';
        $data['html'] .= $select_dosen;
        
        $select_mk = '<td>Mata Kuliah : </td><td><select name="edom_1_mk">';
        $list_mk = $this->mLaporan->edom_get_mk_by_tahun_and_dosen($this->session->userdata('edom_1_tahun'), $this->session->userdata('edom_1_dosen'));
        if ($list_mk != FALSE) {
            foreach ($list_mk as $obj) {
                $selected = '';
                $sess_mk = $this->session->userdata('edom_1_mk');
                if (isset($sess_mk)) {
                    if ($obj->MKKode === $sess_mk) {
                        $selected = ' selected="selected"';
                    }
                }
                $select_mk .= '<option value="'.$obj->MKKode.'"'.$selected.'>'.$obj->Nama_MK.'</option>';
            }
        } else {
            $select_mk = '<td>Mata Kuliah : </td><td><select name="edom_1_mk" disabled="disabled">';
            $select_mk .= '<option selected="selected">Tidak Ada Data Mata Kuliah</option>';
        }
        $select_mk .= '</select></td>';
        $data['html'] .= $select_mk;
        
        $data['html'] .= '</tr></table>';
        $data['html'] .= '<input name="submit" type="submit" value="Lihat">';
        $data['html'] .= '</form>';
        echo $data['html'];
    }
    
    public function edom_1f() {
        print_r($this->input->post('submit'));
        
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
        $enc_str_previous_url_data = $this->encrypt->encode('previous_url_data');
        $html_hidden .= '<input type="hidden" name="'.$enc_str_previous_url_data.'" value="'.$enc_from_lists.'">';
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
        $html_pertanyaan = '<table class="bordered">';
                
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
            if (strpos($str_header, '<!--</table>-->') !== FALSE) {
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
                    //AMRNEEDTOIMPROVE : value=$i ?? >>> id_pilihan
                    $arr_val = $this->mKuesioner->get_all_value_pilihan($obj->id_grup_pilihan);
                    //print_r($arr_val);
                    for ($i = 1; $i <= $obj->jml_pilihan; $i++) {
                        $html_radio .= '<td><input type="radio" name="'.$enc_id_pertanyaan.'" value="'.$this->encrypt->encode($arr_val[($i-1)]->id_pilihan).'"></td>';
                    }
                    if (!empty($obj->jml_pilihan2)) {
                        $arr_val2 = $this->mKuesioner->get_all_value_pilihan($obj->id_grup_pilihan2);
                        //print_r($arr_val2);
                        $enc_id_pertanyaan = $this->encrypt->encode('pilihan2tanya'.$obj->id_pertanyaan.'tanya'.$obj->tipe);
                        //$html_radio .= '</td><td>&nbsp;</td><td>';
                        $html_radio .= '<td></td>';
                        for ($i = 1; $i <= $obj->jml_pilihan2; $i++) {
                            $html_radio .= '<td><input type="radio" name="'.$enc_id_pertanyaan.'" value="'.$this->encrypt->encode($arr_val2[($i-1)]->id_pilihan).'"></td>';
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
            $is_previous_url_data = strpos($index, 'previous_url_data');
            $is_id_periode = strpos($index, 'id_periode');
            $is_id_kuesioner = strpos($index, 'id_kuesioner');
            $is_respondent_id = strpos($index, 'respondent_id');
            $is_pertanyaan = strpos($index, 'tanya');
            $is_custom_data = strpos($index, 'custom_data');
            if ($is_previous_url_data !== FALSE) {
                $previous_url_data = $value;
            }
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
                    $arr_jawaban[$no[1]]->jawaban2 = $this->encrypt->decode($value);
                } else if ($no[0] === 'pilihan') {
                    $arr_jawaban[$no[1]]->jawaban = $this->encrypt->decode($value);
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
        
        $this->load->model('mKuesioner');
        $is_pass = $this->mKuesioner->get_array_jawaban_checker($id_kuesioner);
        foreach ($arr_jawaban as $key => $val) {
            if ($val->tipe == 'isian') {
                if (($val->jawaban != '') && (isset($val->jawaban))) {
                    unset($is_pass[$key]);
                }
            } else {
                unset($is_pass[$key]);
            }
        }
        if (count($is_pass) > 0) {
            $data['html'] = '<table>';
            $data['html'] .= '<tr><td>Harap mengisi kuesioner dengan benar.</td></tr>';
            $data['html'] .= '<tr class="centered"><td><a href="'.site_url('/kuesioner/start/'.$previous_url_data).'">Kembali</a></td></tr>';
            $data['html'] .= '</table>';
            $this->load->view('kuesioner/message_kuesioner',$data);
        } else {
            $this->mKuesioner->insert_jawaban($id_periode,$id_kuesioner,$respondent_id,$arr_jawaban,$custom_data);
            //print_r($id_periode);
            //print_r($id_kuesioner);
            //print_r($respondent_id);
            //print_r($arr_jawaban);
            //redirect(site_url('/kuesioner'));
            $data['html'] = '<table>';
            $data['html'] .= '<tr><td>Terima kasih telah mengisi kuesioner ini.</td></tr>';
            $data['html'] .= '<tr class="centered"><td><a href="'.site_url('/kuesioner').'">Lanjut</a></td></tr>';
            $data['html'] .= '</table>';
            $this->load->view('kuesioner/message_kuesioner',$data);
        }
    }
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */