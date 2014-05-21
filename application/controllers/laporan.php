<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Laporan extends CI_Controller {
    
    function __construct() {
        parent::__construct();
        //$this->load->helper('session_helper');
    }
    
    public function index() {
        $this->session->sess_destroy();
        $this->load->model('mlaporan');
        //$this->mLaporan->edom_0_get_sql_case_grade('jawaban_pilihan',1);
    }
    
    public function edom_0_process() {
        $this->load->model('mlaporan');
        
        if ($this->input->post('submit') == 'Proses') {
            $newdata = array(
                'edom_0_process_tahun' => $this->input->post('edom_0_process_tahun')
            );
            $this->session->set_userdata($newdata);
            //print_r($this->session->userdata('tahun'));
            redirect(current_url(), 'location');
        }
        print_r($this->session->all_userdata());
        $sess_tahun = $this->session->userdata('edom_0_process_tahun');
        
        if (isset($sess_tahun)) {
            $result = $this->mlaporan->edom_0_process_rata2($sess_tahun);
            print_r($result.'<br/>');
            print_r($sess_tahun);
            $this->session->unset_userdata('edom_0_process_tahun');
        }
        
        $list_tahun = $this->mlaporan->edom_0_get_tahun();
        $data['html'] = '<form method="POST" action="'.site_url('laporan/edom_0_process').'">';
        $data['html'] .= '<table><tr>';
        $data['html'] .= '<td>Tahun : </td><td><select name="edom_0_process_tahun[]" multiple="multiple">';
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
        $data['html'] .= '<input name="submit" type="submit" value="Proses">';
        $data['html'] .= '</form>';
        
        $this->load->view('laporan/laporan',$data);
    }
    
    /*public function edom_0() {
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
                            if ($obj2->id != 'TOTAL') {
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
    }*/
    
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
        $this->load->model('mlaporan');
        
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
        
        $list_tahun = $this->mlaporan->edom_0_get_tahun();
        $data['html'] = $html_css.'<form method="POST" action="'.site_url('laporan/edom_0').'">';
        $data['html'] .= '<table><tr>';
        $data['html'] .= '<td align="right">Tahun</td><td style="width:10px;text-align:center;">:</td><td><select name="edom_0_tahun[]" multiple="multiple">';
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
        $data['html'] .= '<div class="centered"><input name="submit" type="submit" value="Lihat"></div>';
        $data['html'] .= '</form>';
        //echo $data['html'];
        
        $list_data = $this->mlaporan->edom_0_get_processed_data($sess_tahun);
        if ($list_data != FALSE) {
            $ttl_ii = 0;
            $i = 1;
            $html_data = '<table class="laporan">{table_header}';
            $row_before = new stdClass();
            //$header_created = FALSE;
            $is_empty_data_layout_created = FALSE;
            $html_data_footer = '';
            $idx = 0;
            $ii = 0;
            $empty_data_layout = '';
            $header_html_data = '';
            $html_header_last_data = '';
            $fix_empty_data_layout = '';
            $fix_header_html_data = '';
            $r = array();
            //20140519
            $arr_nilai = array();
            $arr_header = array();
            $fix_arr_header = array();
            
            while (true) {
                
                if (key_exists($idx, $list_data)) {
                    $obj = $list_data[$idx];
                } else {
                    break;
                }
                
                //row tahun
                if (is_object($row_before)) {
                    if (!property_exists($row_before,'TahunID')) { //untuk baris paling awal
                        $html_data .= '<tr><td></td><td{colspan_1}><b>Tahun : '.$obj->TahunID.'</b></td></tr>';
                    } else if ($row_before->TahunID != $obj->TahunID) { //jika ada perbedaan tahun
                        $html_data .= '<tr><td></td><td{colspan_1}><b>Tahun : '.$obj->TahunID.'</b></td></tr>';
                    }
                }
                //row header
                if ((!property_exists($row_before,'Nama_MK')) &&
                        (!property_exists($row_before,'MKKode')) &&
                        (!property_exists($row_before,'Hari')) &&
                        (!property_exists($row_before,'JamMulai')) &&
                        (!property_exists($row_before,'JamSelesai')) &&
                        (!property_exists($row_before,'RuangID')) &&
                        (!property_exists($row_before,'Nama_Dosen')) &&
                        (!property_exists($row_before,'prodi'))) {
                    $html_data .= '<tr>';
                    $html_data .= '<td align="right">'.$i++.'</td><td>'.$obj->Nama_MK.'<sup>'.$obj->MKKode.'</sup></td><td>'.$obj->Hari.'</td><td><sup>'.substr($obj->JamMulai,0,-3).'</sup>&#8594;<sub>'.substr($obj->JamSelesai,0,-3).'</sub></td><td>'.$obj->RuangID.'</td><td>'.$obj->Nama_Dosen.'</td><td>'.$obj->prodi.'</td>';
                } else if (($row_before->Nama_MK != $obj->Nama_MK) ||
                        ($row_before->MKKode != $obj->MKKode) ||
                        ($row_before->Hari != $obj->Hari) ||
                        ($row_before->JamMulai != $obj->JamMulai) ||
                        ($row_before->JamSelesai != $obj->JamSelesai) ||
                        ($row_before->RuangID != $obj->RuangID) ||
                        ($row_before->Nama_Dosen != $obj->Nama_Dosen) ||
                        ($row_before->prodi != $obj->prodi)) {
                    $html_data .= '<td align="right">'.$i++.'</td><td>'.$obj->Nama_MK.'<sup>'.$obj->MKKode.'</sup></td><td>'.$obj->Hari.'</td><td><sup>'.substr($obj->JamMulai,0,-3).'</sup>&#8594;<sub>'.substr($obj->JamSelesai,0,-3).'</sub></td><td>'.$obj->RuangID.'</td><td>'.$obj->Nama_Dosen.'</td><td>'.$obj->prodi.'</td>';
                }
                
                $respondent_html = '<td>';
                $respondent_html .= '{no_respondent}';
                $respondent_html = trim($respondent_html).'</td>';
                
                if (strpos($obj->flag, 'NONE') !== FALSE) {
                    $pertanyaan_html = '<td>{no_data}</td><td>&nbsp;</td></tr>';
                    //20140519
                    unset($arr_nilai['r'.$i]);
                }
                if (strpos($obj->flag, 'PILIHAN') !== FALSE) {
                    //$pertanyaan_html = '<td align="center" id="r'.$i.'">'.$obj->nilai.'</td>';
                    //if (!$is_empty_data_layout_created) {
                        /*$empty_data_layout .= '<td>&nbsp;</td>';
                        $header_html_data .= '<th align="center">'.++$ii.'</th>';
                    //}
                    if ($obj->flag_no == $ii) {
                        $pertanyaan_html = '<td align="center" id="r'.$i.'">'.$obj->nilai.'</td>';
                    } else {
                        $pertanyaan_html = '<td align="center" id="r'.$i.'">&nbsp;</td>';
                    }*/
                    /*$loop = 1;
                    while ($loop <= 5) {
                        $ii++;
                        if ($obj->flag_no == $ii) {
                            $header_html_data .= '<th align="center">'.$ii.'</th>';
                            $pertanyaan_html = '<td align="center" id="r'.$i.'">'.$obj->nilai.'</td>';
                            break;
                        }
                        $loop++;
                    }*/
                    
                    while (true) {
                        $ii++;
                        if ($obj->flag_no == $ii) {
                            $empty_data_layout .= '<td>&nbsp;</td>';
                            $header_html_data .= '<th align="center" id="rh">'.$ii.'</th>';
                            
                            //20140519
                            $pertanyaan_html = '<td align="center" id="r'.$i.'">'.$obj->nilai.'</td>';
                            $arr_nilai['r'.$i][$ii] = $pertanyaan_html;
                            $arr_header[] = $ii;
                            
                            $pertanyaan_html = '<td id="r'.$i.'">EMPTY</td>';
                            break;
                        }
                    }
                }
                if (strpos($obj->flag, 'TOTAL') !== FALSE) {
                    //$pertanyaan_html = '{added_col_r'.$i.'}<td align="center" id="rr'.$i.'">'.$obj->nilai.'</td>{keterangan}{no_respondent}</tr>';
                    $pertanyaan_html = '<td align="center" id="rr'.$i.'">'.$obj->nilai.'</td>{keterangan}{no_respondent}</tr>';
                    
                    //if (!$is_empty_data_layout_created) {
                        $r[] = 'r'.$i;
                        $empty_data_layout .= '<td>&nbsp;</td><td>&nbsp;</td>';
                        $html_header_last_data = '<th rowspan="2">Rata- Rata</th>';
                        //$is_empty_data_layout_created = TRUE;
                        if (strlen($fix_empty_data_layout) < strlen($empty_data_layout)) {
                            $fix_empty_data_layout = $empty_data_layout;
                            $fix_header_html_data = $header_html_data;
                            $ttl_ii = substr_count($fix_header_html_data, 'id="rh"');
                            $fix_arr_header = $arr_header;
                        }
                        $ii = 0;
                        $empty_data_layout = '';
                        $header_html_data = '';
                        $arr_header = array();
                    //}
                    //print_r($pertanyaan_html);
                    //print_r($obj->keterangan);
                    if (isset($obj->keterangan)) {
                        $pertanyaan_html = str_replace('{keterangan}', '<td id="rr'.$i.'">'.$obj->keterangan.'</td>', $pertanyaan_html);
                    } else {
                        $pertanyaan_html = str_replace('{keterangan}', '<td id="rr'.$i.'">&nbsp;</td>', $pertanyaan_html);
                    }
                    
                    if (isset($obj->respondent)) {
                        $pertanyaan_html = str_replace('{no_respondent}', '<td id="rr'.$i.'">'.$obj->respondent.'</td>', $pertanyaan_html);
                    } else {
                        $pertanyaan_html = str_replace('{no_respondent}', '<td id="rr'.$i.'">&nbsp;</td>', $pertanyaan_html);
                    }
                }
                
                //penambahan </tr>
                if (strpos($obj->flag, '{no_data}') !== FALSE) {
                    $html_data .= $pertanyaan_html.'</tr>';
                } else {
                    $html_data .= $pertanyaan_html;
                }
                
                if (is_object($row_before)) {
                    if (property_exists($row_before,'created_at')) {
                        if ($row_before->created_at > $obj->created_at) {
                            $last_update = $row_before->created_at;
                        } else {
                            $last_update = $obj->created_at;
                        }
                    }
                }
                
                $row_before = $obj;
                $idx++;
            }
            /*foreach ($list_data as $obj) {
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
                
                //$arr_jadwal_id = $this->mLaporan->edom_0_get_jadwal_id_per_jadwal($obj);
                //print_r('<p>'.++$oo.'</p><br/>');
                //print_r($arr_jadwal_id);
                
                //$respondent_data_per_jadwal = $this->mLaporan->edom_0_get_respondent_data_per_jadwal($arr_jadwal_id);
                                
                $respondent_html = '<td>';
                if ($respondent_data_per_jadwal != FALSE) { 
                    foreach ($respondent_data_per_jadwal as $obj3) {
                        $respondent_html .= $obj3->respondent.'<sup>'.$obj3->respon_ke.'</sup> ';
                    }
                } else {
                    $respondent_html .= '{no_respondent}';
                //}
                $respondent_html = trim($respondent_html).'</td>';
                //$html_data .= $respondent_html;
                $calc_data_each_pilihan_per_jadwal = $this->mLaporan->edom_0_get_calc_data_each_pilihan_per_jadwal($arr_jadwal_id);
                
                if ($calc_data_each_pilihan_per_jadwal != FALSE) { 
                    foreach ($calc_data_each_pilihan_per_jadwal as $obj2) {
                        $html_data .= '<td align="center">'.$obj2->nilai.'</td>';
                        if (!$is_empty_data_layout_created) {
                            $empty_data_layout .= '<td>&nbsp;</td>';
                            if ($obj2->id != 'TOTAL') {
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
            }*/
            $html_data .= '</table>';
            
            //$html_data = str_replace('{added_col}', '', $html_data);
            
            foreach ($r as $v) {
                $nilai_temp = $arr_nilai[$v];
                
                /*$jml_kol_by_id = substr_count($html_data, 'id="'.$v.'"');
                $html_added_col = '';
                for ($index = 0; $index > ($jml_kol_by_id-$ttl_ii); $index--) {
                    $html_added_col .= '<td id="'.$v.'" align="center"></td>';
                }
                $html_data = str_replace('{added_col_'.$v.'}', $html_added_col, $html_data);*/
                
                //20140519
                $pos = strpos($html_data, '<td id="'.$v.'">EMPTY</td>');
                if ($pos !== false) {
                    $html_data = substr_replace($html_data, '{for_replace_'.$v.'}', $pos, -1*strlen($html_data));
                    $html_data = str_replace('<td id="'.$v.'">EMPTY</td>', '', $html_data);
                }
                
                $for_replace_str = '';
                foreach ($fix_arr_header as $a) {
                    if (array_key_exists($a, $nilai_temp)) {
                        $for_replace_str .= $nilai_temp[$a];
                    } else {
                        $for_replace_str .= '<td align="center" id="'.$v.'">&nbsp;</td>';
                    }
                }
                $html_data = str_replace('{for_replace_'.$v.'}', $for_replace_str, $html_data);
            }
            
            $fix_empty_data_layout = substr(substr($fix_empty_data_layout, 4), 0, -5);
            if ($fix_empty_data_layout == '') {
                $fix_empty_data_layout = '<td>&nbsp;</td>';
            }
            $html_data = str_replace('{no_data}', $fix_empty_data_layout, $html_data);
            
            $html_header = '<tr><th rowspan="2">No</th><th rowspan="2">Mata Kuliah</th><th colspan="3">Jadwal</th><th rowspan="2">Nama Dosen</th><th rowspan="2">Prodi</th><th colspan="'.$ttl_ii.'">Pertanyaan</th>'.$html_header_last_data.'<th rowspan="2">Keterangan</th><th rowspan="2">Jumlah Respon</th></tr><tr><th>Hari</th><th>Jam</th><th>Kelas</th>'.$fix_header_html_data.'</tr>';
            $html_data = str_replace('{table_header}', $html_header, $html_data);
            
            $html_data = str_replace('{colspan_1}', ' colspan="'.(5+$ttl_ii+4).'"', $html_data);
            
            $data['html'] .= $html_data.'<div class="centered"><span style="font-size:12px;">Terakhir diproses : '.$last_update.'</span></div>';
            
            //print_r($data['html']);
            //exit();
            
            
            //print_r(html_escape($empty_data_layout));
            
            /*$html_data = str_replace('{no_data}', $empty_data_layout, $html_data);
            $html_data = str_replace('{no_respondent}', '&nbsp;', $html_data);
            
            if ($header_html_data == '') {
                $header_html_data = '<th></th>';
            }
            //$html_header = '<tr><th rowspan="2">No</th><th rowspan="2">Mata Kuliah</th><th rowspan="2" colspan="3">Jadwal</th><th rowspan="2">Nama Dosen</th><th colspan="'.$ii.'">Pertanyaan</th><th rowspan="2">Rata-rata</th></tr><tr>'.$header_html_data.'</tr>';
            $html_header = '<tr><th rowspan="2">No</th><th rowspan="2">Mata Kuliah</th><th colspan="3">Jadwal</th><th rowspan="2">Nama Dosen</th><th colspan="'.$ii.'">Pertanyaan</th>'.$html_data_footer.'<th rowspan="2">Keterangan</th></tr><tr><th>Hari</th><th>Jam</th><th>Kelas</th>'.$header_html_data.'</tr>';
            $html_data = str_replace('{table_header}', $html_header, $html_data);
            
            $html_data = str_replace('{colspan_1}', ' colspan="'.(5+$ii+2).'"', $html_data); 
            
            //echo $html_data;
            $data['html'] .= $html_data;*/
        }
        //foreach ($arr_nilai as $value) {
            //print_r($arr_nilai);
        //}
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
            .laporan_a {
                text-decoration: none;
                color: black;
            }
            </style>';
        if ($this->input->post('submit') == 'Lihat') {
        //if ($this->input->post('submit') == 'Lihat') {
            $newdata = array(
                'edom_1_tahun' => $this->input->post('edom_1_tahun'),
                'edom_1_dosen' => $this->input->post('edom_1_dosen')
            );
            if (sisfo_is_dosen()) {
                $newdata['edom_1_dosen'] = sisfo_get_username();
            }
            $this->session->set_userdata($newdata);
            //print_r($this->session->userdata('tahun'));
            redirect(current_url(), 'location');
        } else {
            $sess_tahun = $this->session->userdata('edom_1_tahun');
            if (sisfo_is_dosen()) {
                $newdata['edom_1_dosen'] = sisfo_get_username();
                if (isset($sess_tahun)) {
                    $newdata['edom_1_tahun'] = $sess_tahun;
                }
                $this->session->set_userdata($newdata);
            }
            //redirect(current_url(), 'location');
        }
        
        /*$full_parameter = FALSE;
        //print_r($this->session->userdata('edom_1_tahun').'-'.$this->session->userdata('edom_1_dosen').'-'.$this->session->userdata('edom_1_mk').'-'.$this->session->userdata('edom_1_jadwal').'-');
        if (($this->session->userdata('edom_1_tahun') != NULL) &&
            ($this->session->userdata('edom_1_dosen') != NULL) &&
            ($this->session->userdata('edom_1_mk') != NULL) &&
            ($this->session->userdata('edom_1_jadwal') != NULL)) {
            $full_parameter = TRUE;
        }*/
        print_r($this->session->all_userdata());
        $this->load->model('mlaporan');
        $list_tahun = $this->mlaporan->edom_0_get_tahun();
        $data['html'] = $html_css.'<form method="POST" action="'.site_url('laporan/edom_1').'">';
        $data['html'] .= '<table><tr>';
        
        $data['html'] .= '<td align="right">Tahun</td><td style="width:10px;text-align:center;">:</td><td><select name="edom_1_tahun[]" multiple="multiple">';
        foreach ($list_tahun as $obj) {
            $selected = '';
            //$sess_tahun = $this->session->userdata('edom_1_tahun');
            if (is_array($sess_tahun)) {
                if (in_array($obj->tahun, $sess_tahun) ) {
                    $selected = ' selected="selected"';
                }
            }
            $data['html'] .= '<option value="'.$obj->tahun.'"'.$selected.'>'.$obj->deskripsi.'</option>';
        }
        $data['html'] .= '</select></td>';
        
        $select_dosen = '<td align="right" style="padding-left:10px;">Dosen</td><td style="width:10px;text-align:center;">:</td><td><select name="edom_1_dosen">';
        $list_dosen = $this->mlaporan->edom_1_get_dosen_from_processed();
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
            $select_dosen = str_replace('<select name="edom_1_dosen">','<select name="edom_1_dosen" disabled="disabled" style="margin-top:1px;background-color:white;color:black;border:0 !important;-webkit-appearance: none;text-indent:0.01px;text-overflow:\'\';-moz-appearance:none;">',$select_dosen);
        }
        $data['html'] .= $select_dosen;
        
        /*$select_mk = '<td>Mata Kuliah : </td><td><select name="edom_1_mk">';
        $list_mk = $this->mlaporan->edom_1_get_mk_by_tahun_and_dosen($this->session->userdata('edom_1_tahun'), $this->session->userdata('edom_1_dosen'));
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
        
        /*$arr_mk = explode('&&',$this->session->userdata('edom_1_mk'));
        $mkkode = $arr_mk[0];
        if (key_exists(1, $arr_mk)) {
            $mkname = $arr_mk[1];
        } else {
            $mkname = '';
        }
        $select_jadwal = '<td>Jadwal : </td><td><select name="edom_1_jadwal[]" multiple="multiple">';
        $list_jadwal = $this->mlaporan->edom_1_get_jadwal_by_tahun_and_dosen_and_mk($this->session->userdata('edom_1_tahun'), $this->session->userdata('edom_1_dosen'), $mkkode, $mkname);
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
                
                /*$list_respondent = $this->mlaporan->edom_1_get_respondent_data($this->session->userdata('edom_1_tahun'),
                    $this->session->userdata('edom_1_dosen'), $mkkode, $mkname, $arr_jadwal_all);
                $list_data = $this->mlaporan->edom_1_get_calc_data_each_pilihan($this->session->userdata('edom_1_tahun'),
                    $this->session->userdata('edom_1_dosen'), $mkkode, $mkname, $arr_jadwal_all);
                $list_data2 = $this->mlaporan->edom_1_get_isian_data_each_pertanyaan($this->session->userdata('edom_1_tahun'),
                    $this->session->userdata('edom_1_dosen'), $mkkode, $mkname, $arr_jadwal_all);*/
            /*}
            
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
                    if ($obj->tipe != 'PILIHAN') {
                        $html_data .= '<td align="right">'.$i++.'</td><td>'.$obj->konten.'</td>';
                    } else {
                        $html_data .= '<td colspan="2">'.$obj->konten.'</td>';
                        $i = 1;
                    }
                    $html_data .= '</tr>';
                }
                $html_data .= '</table>';
            }
        }*/
        //$data['html'] .= $html_data;
        
        $data['html'] .= '</tr></table>';
        $data['html'] .= '<div class="centered"><input name="submit" type="submit" value="Lihat"></div>';
        $data['html'] .= '</form>';
        
        /*if () {
            
        }*/
        
        $list_jadwal = $this->mlaporan->edom_1_get_jadwal_by_dosen_and_tahun_from_processed($this->session->userdata('edom_1_dosen'), $this->session->userdata('edom_1_tahun'));
        $aa = 0;
        if ($list_jadwal != FALSE) {
            $jadwal_tampil = '<table class="laporan">';
            $jadwal_tampil .= '<tr><th rowspan="2">No</th><th rowspan="2">Tahun</th><th rowspan="2">Mata Kuliah</th><th colspan="3">Jadwal</th><th rowspan="2">Rata-Rata</th></tr>';
            $jadwal_tampil .= '<tr><th>Hari</th><th>Jam</th><th>Kelas</th></tr>';
            foreach ($list_jadwal as $jd) {
                $url_jadwal2 = $jd->TahunID.'/'.$jd->MKKode.'/'.$jd->Nama_MK.'/'.$jd->HariID.'/'.$jd->JamMulai.'/'.$jd->JamSelesai.'/'.$jd->RuangID;
                $url_jadwal = site_url('laporan/edom_1a').'/'.url_safe_encode($this->encrypt->encode($url_jadwal2));
                $ket_nilai = '';
                if (isset($jd->keterangan)) {
                    $ket_nilai = $jd->nilai.' ('.$jd->keterangan.')';
                } else {
                    $ket_nilai = $jd->nilai;
                    $url_jadwal = '#" style="cursor:default;';
                }
                $jadwal_tampil .= '<tr><td align="right"><a class="laporan_a" href="'.$url_jadwal.'">'.++$aa.'</a></td><td><a class="laporan_a" href="'.$url_jadwal.'">'.$jd->TahunID.'</a></td><td><a class="laporan_a" href="'.$url_jadwal.'">'.$jd->Nama_MK.'<sup>'.$jd->MKKode.'</sup></a></td><td><a class="laporan_a" href="'.$url_jadwal.'">'.$jd->Hari.'</a></td><td><a class="laporan_a" href="'.$url_jadwal.'"><sup>'.$jd->JamMulai.'</sup>&#8594;<sub>'.$jd->JamSelesai.'</sub></a></td><td><a class="laporan_a" href="'.$url_jadwal.'">'.$jd->RuangID.'</a></td><td><a class="laporan_a" href="'.$url_jadwal.'">'.$ket_nilai.'</a></td></tr>';
                
                if (isset($last_update)) {
                    if ($jd->created_at > $last_update) {
                        $last_update = $jd->created_at;
                    }
                } else {
                    $last_update = $jd->created_at;
                }
            }
            $jadwal_tampil .= '</table>';
            $data['html'] .= $jadwal_tampil.'<div class="centered"><span style="font-size:12px;">Terakhir diproses : '.$last_update.'</span></div>';
        }
        
        $this->load->view('laporan/laporan',$data);
        //print_r($list_data);
    }
    
    public function edom_1a($encrypted = NULL) {
        $html_css = '<style>
            .laporan {
                border-collapse:collapse;
                border: 1px solid black;
            }
            .laporan th, .laporan td {
                border: 1px solid black;
            }
            .laporan_a {
                text-decoration: none;
                color: black;
            }
            </style>';
        
        $params = $this->encrypt->decode(url_safe_decode($encrypted));
        $arr_param = explode('/', $params);
        //print_r($params);
        $sess_dosen = $this->session->userdata('edom_1_dosen');
        
        $data['html'] = '<div class="centered"><a href="'.site_url('laporan/edom_1').'">Kembali</a></div>';
        
        if ((count($arr_param) <> 7) && (!isset($sess_dosen))) {
            $this->load->view('laporan/laporan',$data);
            exit();
        }
        
        $this->load->model('mlaporan');
        $table_header = '<table>';
        
        $list_detail = $this->mlaporan->edom_1_get_detail_pilihan_from_processed($sess_dosen, $arr_param[0], $arr_param[1], $arr_param[2], $arr_param[3], $arr_param[4], $arr_param[5], $arr_param[6]);
        //print_r($list_detail);
        
        $Dosen = '';
        $MK = '';
        $Jadwal = '';
        $Tahun = '';
        $respondent = '';
        $jadwal_tampil = '';
        $skor_penilaian = array();
        if ($list_detail != FALSE) {
            $jadwal_tampil = '{table_header}<table class="laporan" style="margin: 0px auto;">';
            $jadwal_tampil .= '<tr><th>No</th><th>Aspek yang Dinilai</th><th>Rata-rata</th><th>Keterangan</th></tr>';
            foreach ($list_detail as $o) {
                $algn_pertanyaan = '';
                $algn2 = ' align="center"';
                $algn3 = ' align="right"';
                //centering TOTAL
                if ($o->flag_no == 0) {
                    $algn_pertanyaan = ' align="center" style="background:black;color:white;font-weight:bold;"';
                    $algn2 = ' align="center" style="background:black;color:white;font-weight:bold;"';
                    $algn3 = ' align="right" style="background:black;color:white;font-weight:bold;"';
                    $o->flag_no = '';
                }
                $jadwal_tampil .= '<tr><td'.$algn3.'>'.$o->flag_no.'</td><td'.$algn_pertanyaan.'>'.$o->pertanyaan.'</td><td'.$algn2.'>'.$o->nilai.'</td><td'.$algn2.'>'.$o->keterangan.'</td></tr>';
                
                $Dosen = $o->Nama_Dosen.'<sup>'.$o->DosenID.'</sup>';
                $MK = $o->Nama_MK.'<sup>'.$o->MKKode.'</sup>';
                $Jadwal = $o->Hari.', <sup>'.$o->JamMulai.'</sup>&#8594;<sub>'.$o->JamSelesai.'</sub> ('.$o->RuangID.')';
                $Tahun = $o->TahunID;
                $respondent = $o->respondent;
                $skor_temp = $this->mlaporan->edom_1_get_detail_penilaian($o->id_pertanyaan);
                if ($skor_temp !== FALSE) {
                    $skor_penilaian = $skor_temp;
                }
            }
            $jadwal_tampil .= '</table>';
        }
        
        
        $jadwal_header = '<table style="margin: 0px auto;border-collapse: collapse;">';
        $jadwal_header .= '<tr><td style="font-size:150%; text-align: center; padding-bottom:.5em;" colspan="2"><b>LEMBAR EVALUASI DOSEN OLEH MAHASISWA</b></td></tr>';
        $jadwal_header .= '<tr><td><span style="width:115px;display:inline-block;">Nama Dosen</span></td><td>: '.$Dosen.'</td></tr>';
        $jadwal_header .= '<tr><td><span style="width:115px;display:inline-block;">Mata Kuliah</span></td><td>: '.$MK.'</td></tr>';
        $jadwal_header .= '<tr><td><span style="width:115px;display:inline-block;">Jadwal</span></td><td>: '.$Jadwal.'</td></tr>';
        $jadwal_header .= '<tr><td><span style="width:115px;display:inline-block;">Tahun Akademik</span></td><td>: '.$Tahun.'</td></tr>';
        $jadwal_header .= '<tr><td><span style="width:115px;display:inline-block;">Koresponden</span></td><td>: '.$respondent.'</td></tr>';
        $jadwal_header .= '</table>';
        
        $skor_tampil = '';
        foreach ($skor_penilaian as $id) {
            //print_r($id);
            //$skor_tampil .= '<div class="centered"><div style="display:inline-block;text-align:justify;border:1px solid black;"><span style="padding-left:20px;"></span><span style="font-weight:bold;">Skor Penilaian</span><br/><span style="padding-left:20px;"></span>';
            $skor_tampil .= '<table class="laporan" style="margin-top:10px;margin-bottom:20px;"><tr><th colspan="3" style="background:black;color:white;">Skor Penilaian</th></tr><tr>';
            $i = 0;
            $ttl_skor = count($id);
            foreach ($id as $ido) {
                $i++;
                //print_r($ido);
                //$skor_tampil .= '<span style="padding-right:20px;">'.$ido->min_nilai.' - '.$ido->max_nilai.' = '.$ido->deskripsi.'</span>';
                $skor_tampil .= '<td style="padding:0 15px 0 15px;">'.$ido->min_nilai.' - '.$ido->max_nilai.' = '.$ido->deskripsi.'</td>';
                //if ((($i % 3) == 0) && ($ttl_skor > $i)) {
                if (($i % 3) == 0) {
                    //$skor_tampil .= '<br/><span style="padding-left:20px;"></span>';
                    $skor_tampil .= '</tr><tr>';
                }
            }
            //$skor_tampil .= '</div></div>';
            if ((substr($skor_tampil, (strlen($skor_tampil)-4)+1)) == '<tr>') {
                $skor_tampil = substr($skor_tampil, 0, (strlen($skor_tampil)-4)+1);
            } else {
                $skor_tampil .= '</tr>';
            }
            $skor_tampil .= '</table>';
        }
        
        
        
        $jadwal_tampil = str_replace('{table_header}', $html_css.$jadwal_header.$skor_tampil, $jadwal_tampil);
        
        if (isset($jadwal_tampil)) {
            $data['html'] .= $jadwal_tampil;
            $this->load->view('laporan/laporan',$data);
        } else {
            redirect(site_url('laporan/edom_1'), 'location');
        }
    }
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */