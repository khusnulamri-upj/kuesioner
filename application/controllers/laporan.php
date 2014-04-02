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
    
    public function edom_0() {
        $html_css = '<style>
            .laporan {
                border-collapse:collapse;
                border: 1px solid black;
            }
            .laporan th, .laporan td {
                border: 1px solid black;
            }
            </style>';
        $this->load->model('mLaporan');
        
        if ($this->input->post('submit') == 'Lihat') {
            $newdata = array(
                'edom_0_tahun' => $this->input->post('edom_0_tahun')
            );
            $this->session->set_userdata($newdata);
            //print_r($this->session->userdata('tahun'));
            redirect(current_url(), 'location');
        }
        print_r($this->session->all_userdata());
        $sess_tahun = $this->session->userdata('edom_0_tahun');
        
        $list_tahun = $this->mLaporan->edom_0_get_tahun();
        $data['html'] = $html_css.'<form method="POST" action="'.site_url('laporan/edom_0').'">';
        $data['html'] .= '<table><tr>';
        $data['html'] .= '<td>Tahun : </td><td><select name="edom_0_tahun[]" multiple="multiple">';
        foreach ($list_tahun as $obj) {
            $selected = '';
            if (is_array($sess_tahun)) {
                if (in_array($obj->tahun, $sess_tahun) ) {
                    $selected = ' selected="selected"';
                }
            }
            $data['html'] .= '<option value="'.$obj->tahun.'"'.$selected.'>'.$obj->deskripsi.'</option>';
        }
        $data['html'] .= '</select></td>';
        
        $data['html'] .= '</tr></table>';
        $data['html'] .= '<input name="submit" type="submit" value="Lihat">';
        $data['html'] .= '</form>';
        //echo $data['html'];
        
        $list_data = $this->mLaporan->edom_0_get_list_jadwal($sess_tahun);
        if ($list_data != FALSE) {
            $i = 1;
            $html_data = '<table class="laporan">{table_header}';
            $row_before = new stdClass();
            $header_created = FALSE;
            $is_empty_data_layout_created = FALSE;
            $header_html_data = '';
            $empty_data_layout = '';
            $html_data_footer = '';
            $ii = 0;
            foreach ($list_data as $obj) {
                if (is_object($row_before)) {
                    if (!property_exists($row_before,'TahunID')) {
                        $html_data .= '<tr><td></td><td{colspan_1}><b>Tahun : '.$obj->TahunID.'</b></td></tr>';
                    } else if ($row_before->TahunID != $obj->TahunID) {
                        $html_data .= '<tr><td></td><td{colspan_1}><b>Tahun : '.$obj->TahunID.'</b></td></tr>';
                    }
                }
                $html_data .= '<tr>';
                //$html_data .= '<td>'.$i++.'</td><td>'.$obj->Nama_MK.'<sup>'.$obj->MKKode.'</sup></td><td>'.$obj->Hari.'</td><td><sup>'.substr($obj->JamMulai,0,-3).'</sup>&#8594;<sub>'.substr($obj->JamSelesai,0,-3).'</sub></td><td>'.$obj->RuangID.'</td><td>'.$obj->Nama_Dosen.'<sup>'.$obj->DosenID.'</sup></td>';
                $html_data .= '<td align="right">'.$i++.'</td><td>'.$obj->Nama_MK.'<sup>'.$obj->MKKode.'</sup></td><td>'.$obj->Hari.'</td><td><sup>'.substr($obj->JamMulai,0,-3).'</sup>&#8594;<sub>'.substr($obj->JamSelesai,0,-3).'</sub></td><td>'.$obj->RuangID.'</td><td>'.$obj->Nama_Dosen.'</td>';
                
                $arr_jadwal_id = $this->mLaporan->edom_0_get_jadwal_id_per_jadwal($obj);
                //print_r('<p>'.++$oo.'</p><br/>');
                //print_r($arr_jadwal_id);
                
                $respondent_data_per_jadwal = $this->mLaporan->edom_0_get_respondent_data_per_jadwal($arr_jadwal_id);
                                
                $respondent_html = '<td>';
                if ($respondent_data_per_jadwal != FALSE) { 
                    foreach ($respondent_data_per_jadwal as $obj3) {
                        $respondent_html .= $obj3->respondent.'<sup>'.$obj3->respon_ke.'</sup> ';
                    }
                } else {
                    $respondent_html .= '{no_respondent}';
                }
                $respondent_html = trim($respondent_html).'</td>';
                //$html_data .= $respondent_html;
                $calc_data_each_pilihan_per_jadwal = $this->mLaporan->edom_0_get_calc_data_each_pilihan_per_jadwal($arr_jadwal_id);
                
                if ($calc_data_each_pilihan_per_jadwal != FALSE) { 
                    foreach ($calc_data_each_pilihan_per_jadwal as $obj2) {
                        $html_data .= '<td align="center">'.$obj2->nilai.'</td>';
                        if (!$is_empty_data_layout_created) {
                            $empty_data_layout .= '<td>&nbsp;</td>';
                            if ($obj2->id != 'FOOTER') {
                                $header_html_data .= '<th>'.++$ii.'</th>';
                                $html_data_footer = '<th rowspan="2">Rata- Rata</th>';
                            }
                        }
                    }
                    if ($empty_data_layout != '') {
                        $is_empty_data_layout_created = TRUE;
                    }
                } else {
                    $html_data .= '<td>{no_data}</td>';
                }
                
                $html_data .= $respondent_html;
                $html_data .= '</tr>';
                
                $row_before = $obj;
            }
            $html_data .= '</table>';
            
            $empty_data_layout = substr($empty_data_layout, 4);
            $empty_data_layout = substr($empty_data_layout, 0, -5);
            
            //print_r(html_escape($empty_data_layout));
            
            $html_data = str_replace('{no_data}', $empty_data_layout, $html_data);
            $html_data = str_replace('{no_respondent}', '&nbsp;', $html_data);
            
            if ($header_html_data == '') {
                $header_html_data = '<th></th>';
            }
            //$html_header = '<tr><th rowspan="2">No</th><th rowspan="2">Mata Kuliah</th><th rowspan="2" colspan="3">Jadwal</th><th rowspan="2">Nama Dosen</th><th colspan="'.$ii.'">Pertanyaan</th><th rowspan="2">Rata-rata</th></tr><tr>'.$header_html_data.'</tr>';
            $html_header = '<tr><th rowspan="2">No</th><th rowspan="2">Mata Kuliah</th><th colspan="3">Jadwal</th><th rowspan="2">Nama Dosen</th><th colspan="'.$ii.'">Pertanyaan</th>'.$html_data_footer.'<th rowspan="2">Keterangan</th></tr><tr><th>Hari</th><th>Jam</th><th>Kelas</th>'.$header_html_data.'</tr>';
            $html_data = str_replace('{table_header}', $html_header, $html_data);
            
            $html_data = str_replace('{colspan_1}', ' colspan="'.(5+$ii+2).'"', $html_data); 
            
            //echo $html_data;
            $data['html'] .= $html_data;
        }
        $this->load->view('laporan/laporan',$data);
    }
    
    //per dosen per mata kuliah
    public function edom_1() {
        /*if (!sisfo_is_dosen()) {
            exit();
        }*/
        $html_css = '<style>
            .laporan {
                border-collapse:collapse;
                border: 1px solid black;
            }
            .laporan th, .laporan td {
                border: 1px solid black;
            }
            </style>';
        if (($this->input->post('submit') == 'Kirim Parameter') || ($this->input->post('submit') == 'Lihat')) {
        //if ($this->input->post('submit') == 'Lihat') {
            $newdata = array(
                'edom_1_tahun' => $this->input->post('edom_1_tahun'),
                'edom_1_dosen' => $this->input->post('edom_1_dosen'),
                'edom_1_mk' => $this->input->post('edom_1_mk'),
                'edom_1_jadwal' => $this->input->post('edom_1_jadwal')
            );
            if (sisfo_is_dosen()) {
                $newdata['edom_1_dosen'] = sisfo_get_username();
            }
            $this->session->set_userdata($newdata);
            //print_r($this->session->userdata('tahun'));
            redirect(current_url(), 'location');
        }
        $full_parameter = FALSE;
        //print_r($this->session->userdata('edom_1_tahun').'-'.$this->session->userdata('edom_1_dosen').'-'.$this->session->userdata('edom_1_mk').'-'.$this->session->userdata('edom_1_jadwal').'-');
        if (($this->session->userdata('edom_1_tahun') != NULL) &&
            ($this->session->userdata('edom_1_dosen') != NULL) &&
            ($this->session->userdata('edom_1_mk') != NULL) &&
            ($this->session->userdata('edom_1_jadwal') != NULL)) {
            $full_parameter = TRUE;
        }
        print_r($this->session->all_userdata());
        $this->load->model('mLaporan');
        $list_tahun = $this->mLaporan->edom_0_get_tahun();
        $data['html'] = $html_css.'<form method="POST" action="'.site_url('laporan/edom_1').'">';
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
        $list_dosen = $this->mLaporan->edom_1_get_dosen_by_tahun($this->session->userdata('edom_1_tahun'));
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
        if (sisfo_is_dosen()) {
            $select_dosen = str_replace('<select name="edom_1_dosen">','<select name="edom_1_dosen" disabled="disabled">',$select_dosen);
        }
        $data['html'] .= $select_dosen;
        
        $select_mk = '<td>Mata Kuliah : </td><td><select name="edom_1_mk">';
        $list_mk = $this->mLaporan->edom_1_get_mk_by_tahun_and_dosen($this->session->userdata('edom_1_tahun'), $this->session->userdata('edom_1_dosen'));
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
        
        /*$select_jadwal = '<td>Jadwal : </td><td><select name="edom_1_jadwal">';
        $list_jadwal = $this->mLaporan->edom_1_get_jadwal_by_tahun_and_dosen_and_mk($this->session->userdata('edom_1_tahun'), $this->session->userdata('edom_1_dosen'), $this->session->userdata('edom_1_mk'));
        if ($list_jadwal != FALSE) {
            foreach ($list_jadwal as $obj) {
                $selected = '';
                $sess_jadwal = $this->session->userdata('edom_1_jadwal');
                if (isset($sess_jadwal)) {
                    if ($obj->jadwal === $sess_jadwal) {
                        $selected = ' selected="selected"';
                    }
                }
                $select_jadwal .= '<option value="'.$obj->jadwal.'"'.$selected.'>'.$obj->deskripsi.'</option>';
            }
        } else {
            $select_jadwal = '<td>Jadwal : </td><td><select name="edom_1_jadwal" disabled="disabled">';
            $select_jadwal .= '<option selected="selected">Tidak Ada Data Jadwal</option>';
        }
        $select_jadwal .= '</select></td>';
        $data['html'] .= $select_jadwal;*/
        
        $arr_mk = explode('&&',$this->session->userdata('edom_1_mk'));
        $mkkode = $arr_mk[0];
        if (key_exists(1, $arr_mk)) {
            $mkname = $arr_mk[1];
        } else {
            $mkname = '';
        }
        $select_jadwal = '<td>Jadwal : </td><td><select name="edom_1_jadwal[]" multiple="multiple">';
        $list_jadwal = $this->mLaporan->edom_1_get_jadwal_by_tahun_and_dosen_and_mk($this->session->userdata('edom_1_tahun'), $this->session->userdata('edom_1_dosen'), $mkkode, $mkname);
        if ($list_jadwal != FALSE) {
            foreach ($list_jadwal as $obj) {
                $selected = '';
                $sess_jadwal = $this->session->userdata('edom_1_jadwal');
                if (is_array($sess_jadwal)) {
                    if (in_array($obj->jadwal, $sess_jadwal) ) {
                        $selected = ' selected="selected"';
                    }
                }
                $select_jadwal .= '<option value="'.$obj->jadwal.'"'.$selected.'>'.$obj->deskripsi.'</option>';
            }
            $select_jadwal .= '</select></td>';
        } else {
            $select_jadwal = '<td>Jadwal : </td><td><select name="edom_1_jadwal[]" multiple="multiple" disabled="disabled">';
            $select_jadwal .= '<option>Tidak Ada Data Jadwal</option>';
        }
        
        $data['html'] .= $select_jadwal;
        
        //$data['html'] .= '<td><input name="submit" type="submit" value="Kirim Parameter"></td></tr></table>';
        //$data['html'] .= '<input name="submit" type="submit" value="Kirim Parameter">';
        $data['html'] .= '</tr></table>';
        $data['html'] .= '<input name="submit" type="submit" value="Lihat">';
        $data['html'] .= '</form>';
        //echo $data['html'];
        
        $list_data = '';
        $html_data = '';
        if ($full_parameter) {
            $arr_jadwal_all = array();
            if (is_array($this->session->userdata('edom_1_jadwal'))) {
                foreach ($this->session->userdata('edom_1_jadwal') as $value) {
                    $arr_jadwal = explode('&&',$value);
                    $obj = new stdClass();
                    $obj->HariID = $arr_jadwal[0];
                    $obj->JamMulai = $arr_jadwal[1];
                    $obj->JamSelesai = $arr_jadwal[2];
                    $obj->RuangID = $arr_jadwal[3];
                    $arr_jadwal_all[] = $obj;
                }
                
                $list_respondent = $this->mLaporan->edom_1_get_respondent_data($this->session->userdata('edom_1_tahun'),
                    $this->session->userdata('edom_1_dosen'), $mkkode, $mkname, $arr_jadwal_all);
                $list_data = $this->mLaporan->edom_1_get_calc_data_each_pilihan($this->session->userdata('edom_1_tahun'),
                    $this->session->userdata('edom_1_dosen'), $mkkode, $mkname, $arr_jadwal_all);
                $list_data2 = $this->mLaporan->edom_1_get_isian_data_each_pertanyaan($this->session->userdata('edom_1_tahun'),
                    $this->session->userdata('edom_1_dosen'), $mkkode, $mkname, $arr_jadwal_all);
            }
            
            if ($list_respondent != NULL) {
                $html_data = '<table>';
                $html_data .= '<tr><td>Koresponden</td><td>: ';
                foreach ($list_respondent as $obj) {
                    $html_data .= $obj->respondent.'<sup>'.$obj->respon_ke.'</sup> ';
                    
                }
                $html_data .= '</td></tr>';
                $html_data .= '</table>';
            }
            
            if ($list_data != NULL) {
                $html_data .= '<table class="laporan">';
                $html_data .= '<tr><th>No</th><th>Aspek yang Dinilai</th><th>Rata-Rata</th></tr>';
                $i = 1;
                foreach ($list_data as $obj) {
                    $html_data .= '<tr>';
                    if ($obj->id != 'FOOTER') {
                        $html_data .= '<td align="right">'.$i++.'</td><td>'.$obj->pertanyaan.'</td><td align="center">'.$obj->nilai.'</td>';
                    } else {
                        $html_data .= '<td align="right"></td><td align="center"><b>'.$obj->pertanyaan.'</b></td><td align="center"><b>'.$obj->nilai.'</b></td>';
                    }
                    $html_data .= '</tr>';
                }
                $html_data .= '</table>';
            }
            
            if ($list_data2 != NULL) {
                $html_data .= '<table>';
                $i = 1;
                foreach ($list_data2 as $obj) {
                    $html_data .= '<tr>';
                    if ($obj->tipe != 'PERTANYAAN') {
                        $html_data .= '<td align="right">'.$i++.'</td><td>'.$obj->konten.'</td>';
                    } else {
                        $html_data .= '<td colspan="2">'.$obj->konten.'</td>';
                        $i = 1;
                    }
                    $html_data .= '</tr>';
                }
                $html_data .= '</table>';
            }
        }
        $data['html'] .= $html_data;
        
        $this->load->view('laporan/laporan',$data);
        //print_r($list_data);
    }
    
    /*public function edom_1f() {
        print_r($this->input->post('submit'));
        
    }*/
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */